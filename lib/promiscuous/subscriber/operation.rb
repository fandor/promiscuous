class Promiscuous::Subscriber::Operation
  attr_accessor :model, :id, :operation, :attributes, :version
  delegate :message, :to => :unit_of_work

  def initialize(payload)
    if payload.is_a?(Hash)
      self.id         = payload['id']
      self.operation  = payload['operation'].try(:to_sym)
      self.attributes = payload['attributes']
      self.version    = payload['version']
      self.model      = self.get_subscribed_model(payload) if payload['types']

      # Promiscuous.debug "************************************"
      # Promiscuous.debug "payload: #{payload}"
      # #Promiscuous.debug "Promiscuous::Subscriber::Operation: #{self.inspect}"
      # Promiscuous.debug "************************************"
    end
  end

  def key
    "#{self.model}:#{self.id}"
  end

  def get_subscribed_model(payload)
    [message.app, '*'].each do |app|

      # Promiscuous.debug "************************************"
      # Promiscuous.debug "app: #{app.inspect}"

      app_mapping = Promiscuous::Subscriber::Model.mapping[app] || {}
      payload['types'].to_a.each do |ancestor|
        model = app_mapping[ancestor]
        #model = ancestor

        # Promiscuous.debug "payload['types'] ancestor: #{ancestor}"
        # Promiscuous.debug "model: #{model.inspect}"
        # Promiscuous.debug "************************************"

        return model if model
      end
    end
    nil
  end

  def warn(msg)
    Promiscuous.warn "[receive] #{msg} #{message.payload}"
  end

  def create(options={})
    model.__promiscuous_fetch_new(id).tap do |instance|
      instance.__promiscuous_eventual_consistency_update(self)
      instance.__promiscuous_update(self)
      instance.save!
    end
  rescue Exception => e
    if model.__promiscuous_duplicate_key_exception?(e)
      options[:on_already_created] ||= proc { warn "ignoring already created record" }
      options[:on_already_created].call
    else
      raise e
    end
  end

  def update(should_create_on_failure=true)
    #Promiscuous.debug "***************----------------->  update"
    model.__promiscuous_fetch_existing(id).tap do |instance|
      if instance.__promiscuous_eventual_consistency_update(self)
        #Promiscuous.debug "***************----------------->  begin update"

        instance.__promiscuous_update(self)
        #Promiscuous.debug "***************----------------->  update complete"

        instance.save!
        #Promiscuous.debug "***************----------------->  save complete"
      end
    end
  rescue model.__promiscuous_missing_record_exception
    warn "upserting"
    create :on_already_created => proc { update(false) if should_create_on_failure }
  end

  def destroy
    Promiscuous::Subscriber::Worker::EventualDestroyer.postpone_destroy(model, id)
    model.__promiscuous_fetch_existing(id).destroy
  rescue model.__promiscuous_missing_record_exception
    warn "record doesn't exist"
  end

  def execute
    # Promiscuous.debug "************************************"
    # Promiscuous.debug "CASE EXECUTE"
    # Promiscuous.debug "************************************"
    case operation
    when :create
      # Promiscuous.debug "************************************"
      # Promiscuous.debug "CREATE"
      # Promiscuous.debug "************************************"
      create
    when :update
      # Promiscuous.debug "************************************"
      # Promiscuous.debug "UPDATE"
      # Promiscuous.debug "************************************"
      update
    when :destroy
      # Promiscuous.debug "************************************"
      # Promiscuous.debug "DESTROY"
      # Promiscuous.debug "************************************"
      destroy
    end
  end

  def unit_of_work
    @unit_of_work ||= Promiscuous::Subscriber::UnitOfWork.current
  end
end

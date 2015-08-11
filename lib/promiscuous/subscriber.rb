module Promiscuous::Subscriber
  extend Promiscuous::Autoload
  autoload :Worker, :UnitOfWork, :Message, :Model, :Operation, :Message

  extend ActiveSupport::Concern

  included do
    if defined?(Mongoid::Document) && self < Mongoid::Document
      include Promiscuous::Subscriber::Model::Mongoid
    elsif defined?(ActiveRecord::Base) && self < ActiveRecord::Base
      Promiscuous.debug "************************************"
      Promiscuous.debug "defined?(ActiveRecord::Base) && self < ActiveRecord::Base -- #{self.name}"
      Promiscuous.debug "************************************"
      include Promiscuous::Subscriber::Model::ActiveRecord
    else
      raise "What kind of model is this? try including Promiscuous::Subscriber after all your includes"
    end
  end
end

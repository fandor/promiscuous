module Promiscuous::ControllerMiddleware
  extend ActiveSupport::Concern

#   def process_action(*args)
#     Rails.logger.info "***********************************"
#     Rails.logger.info "*** PROMISCUOUS: process_action"
#     #Rails.logger.info "*** PROMISCUOUS: self.current_user: #{self.current_user}"

#     ### NOTE: This line was failing when loaded into matinee with authlogic error - TM
#     #Promiscuous::Publisher::Context::Base.current.current_user = self.current_user if self.respond_to?(:current_user)

#     Rails.logger.info "***********************************"
#     Rails.logger.info "*** call: super"
#     super
#     Rails.logger.info "***********************************"
#     Rails.logger.info "*** Promiscuous::Publisher::Context::Base.current.current_user = nil"
#     Promiscuous::Publisher::Context::Base.current.current_user = nil
#   end
end

class Promiscuous::Railtie < Rails::Railtie
  initializer 'load promiscuous' do
    ActiveSupport.on_load(:action_controller) do
      include Promiscuous::ControllerMiddleware
    end

    config.after_initialize do
      Promiscuous::Config.configure unless Promiscuous::Config.configured?
      Promiscuous::Loader.prepare

      ActionDispatch::Reloader.to_prepare do
        Promiscuous::Loader.prepare
      end
      ActionDispatch::Reloader.to_cleanup do
        Promiscuous::Loader.cleanup
      end
    end
  end
end

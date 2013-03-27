module Guachiman
  module Permissible
    extend ActiveSupport::Concern

    included do
      before_filter :authorize
    end

    def current_permission
      @current_permission ||= Permission.new current_user
    end

    def current_resource
      nil
    end

    def current_user
      raise 'This method must be implemented'
    end

    def not_authorized
      raise 'This method must be implemented'
    end

    def authorize
      if !current_permission.allow?(params[:controller], params[:action], current_resource)
        not_authorized
      end
    end
  end
end

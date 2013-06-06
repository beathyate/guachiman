module Guachiman
  module Permissible
    extend ActiveSupport::Concern

    included do
      before_filter :authorize
      helper_method :current_user
      helper_method :current_permission
    end

    def current_user
      raise 'This method must be implemented'
    end

    def current_permission
      @current_permission ||= Permission.new current_user
    end

    def current_resource
      nil
    end

    def authorize
      if current_permission.allow? controller_name, action_name, current_resource
        current_permission.permit_params! params
      else
        not_authorized
      end
    end

    def not_authorized
      session[:next] = request.url unless current_user
      redirect_to root_path, alert: t(current_user ? 'flashes.not_authorized' : 'flashes.please_login')
    end
  end
end

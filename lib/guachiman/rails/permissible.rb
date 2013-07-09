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
        if current_user
          not_authorized
        else
          not_signed_in
        end
      end
    end

    def not_authorized
      redirect_to root_path, alert: t('flashes.not_authorized')
    end

    def not_signed_in
      session[:next] = request.url
      redirect_to sign_in_path, alert: t('flashes.please_sign_in')
    end
  end
end

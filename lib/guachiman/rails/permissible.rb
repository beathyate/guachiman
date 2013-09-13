module Guachiman
  module Permissible
    extend ActiveSupport::Concern

    included do
      before_filter :authorize
      helper_method :current_user
      helper_method :current_permission
      helper_method :current_resource
    end

    def current_user
      raise 'This method must be implemented'
    end

    def current_permission
      @current_permission ||= Permission.new current_user, request
    end

    def current_resource
      nil
    end

    def authorize
      if current_permission.allow? controller_name, action_name, current_resource
        current_permission.permit_params! params
      else
        if request.get?
          current_user ? not_authorized : not_signed_in
        else
          render_unauthorized
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

    def render_unauthorized
      render text: "NO", status: :unauthorized
    end
  end
end

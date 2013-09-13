class Permission
  include Guachiman::Permissions
  include Guachiman::Params

  attr_reader :current_user, :current_request

  def initialize user, request
    @current_user    = user
    @current_request = request

    if current_user.nil?
      guest
    elsif current_user.admin?
      admin
    else
      member
    end
  end

private

  def guest
  end

  def member
    guest
  end

  def admin
    allow_all!
  end
end

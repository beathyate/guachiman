class Permission
  include Guachiman::Permissions
  include Guachiman::Params

  attr_reader :user, :request

  def initialize current_user, current_request
    @user    = current_user
    @request = current_request

    if user.nil?
      guest
    elsif user.admin?
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

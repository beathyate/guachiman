class Permission
  include Guachiman::Permissions
  include Guachiman::Params

  def initialize user, options={}
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

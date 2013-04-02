class Permission
  include Guachiman::Permissions
  # include Guachiman::Params

  def initialize user
    if user
      if user.admin?
        allow_all!
      end
    end
  end
end

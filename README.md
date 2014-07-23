Guachiman
=========

Minimal authorization library inspired by [RailsCast #385 Authorization from Scratch][1] by Ryan Bates.

Guachiman allows you to store authorization rules as a tree of permissions nested within groups.
Permissions can be either `true` or a block that takes an object. In that case the permission will
be the result of the block evaluation.

[1]: http://railscasts.com/episodes/385-authorization-from-scratch-part-1

Installation
------------

Add this line to your application's Gemfile:

```ruby
gem 'guachiman'
```

And then execute:

```bash
$ bundle
```

Or install it directly:

```bash
$ gem install guachiman
```

Usage
-----

Describe your authorization objects in this way:

```ruby
class Authorization
  include Guachiman

  def initialize(user)
    @current_user = user

    if @current_user
      if @current_user.admin?
        admin_authorization
      else
        member_authorization
      end
    else
      guest_authorization
    end
  end

private

  def guest_authorization
    allow :sessions

    allow :users, [:new, :create]
  end

  def member_authorization
    guest_authorization

    allow :users, [:show, :edit, :update] do |user_id|
      @current_user.id == user_id
    end
  end

  def admin_authorization
    allow
  end
end
```

* `#allow` takes two parameters, `groups` and `permissions`, and a block. All are optional and depend on how
specific you want to be. Always consider the following:

1. If you call `#allow` without params, it means all combinations of group and permission will be allowed.
2. If you call `#allow` specifying only the group, it all permissions will be allowed.
3. You can always pass a block that takes one object, and the permission will be whatever it returns when evaluated.

#### Examples

```ruby
user  = User.find(user_id)
admin = User.find(admin_id)

user_authorization  = Authorization.new(user)
admin_authorization = Authorization.new(admin)

user_authorization.allow?(:sessions, :new)
# => true

user_authorization.allow?(:users, :show)
# => false

user_authorization.allow?(:users, :show, user.id)
# => true

admin_authorization.allow?(:users, :show)
# => true
```

* `#allow?` takes a `group` param, a `permission` param, a an optional `object` param to evaluate in the block.

License
-------

MIT

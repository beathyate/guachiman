Guachiman
=========

Minimal authorization gem. Inspired on [RailsCast #385 Authorization from Scratch][1] from Ryan Bates.

It simply stores a tree of permissions separated by groups. Permissions can be either `true` or a block
that takes an object. In that case the permission will be the result of the block evaluation.

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

Or install it yourself as:

```bash
$ gem install guachiman
```

Usage
-----

Describe your authorization objects in this way:

```ruby
class Authorization
  include Guachiman

  def initialize user
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
    allow :sessions, [:new, :create, :destroy]
    allow :users,    [:new, :create]
  end

  def member_authorization
    guest_authorization

    allow :users, [:show, :edit, :update] do |user_id|
      @current_user.id == user_id
    end
  end

  def admin_authorization
    allow_all!
  end
end
```

* `#allow` takes a **group** params key or array of keys and an array of **permissions**.
* `#allow_all!` is a convenience method to allow **all** groups and permissions.

And you can use it in this way:

```ruby
user  = User.find(user_id)
admin = User.find(admin_id)

user_authorization  = Authorization.new(user)
admin_authorization = Authorization.new(admin)

user_authorization.allow?(:users, :show)
# => false

user_authorization.allow?(:users, :show, user.id)
# => true

admin_authorization.allow?(:users, :show)
# => true
```

* `#allow?` takes a **group** param, a **permission** param, a an optional **object** param to evaluate in the block.

License
-------

MIT

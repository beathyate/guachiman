Guachiman
=========


Minimal authorization library inspired by [RailsCast #385 Authorization from Scratch][1] by Ryan Bates.

Guachiman allows you to store authorization rules as a tree of permissions nested within groups.
Permissions can be either `true` or a block that takes an object. In that case the permission will
be the result of the block evaluation.

[![Codeship Status for goddamnhippie/guachiman][2]][3]

[1]: http://railscasts.com/episodes/385-authorization-from-scratch-part-1
[2]: https://www.codeship.io/projects/f3a90030-f43c-0131-65bd-5a054a318c0e/status
[3]: https://www.codeship.io/projects/28071


Upgrading to v1.0.0
-------------------

**Starting with version 1.0.0 all Rails-specific code and support has been removed.**
A new gem called guachiman-rails will be the recommended way to use Guachiman with Rails.
More info [in the repo][4].

[4]: https://github.com/goddamnhippie/guachiman-rails


Installation
------------

Add this line to your application's `Gemfile`:

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
    if @current_user = user
      member_authorization
    else
      guest_authorization
    end
  end

private

  def guest_authorization
    allow :sessions, [:new]
  end

  def member_authorization
    guest_authorization

    allow :users, [:show, :edit, :update] do |user_id|
      @current_user.id == user_id
    end
  end
end
```

So that you can use them like this:

```ruby
user  = User.find(user_id)

guest_authorization = Authorization.new
user_authorization  = Authorization.new(user)

guest_authorization.allow?(:sessions, :new)
# => true

user_authorization.allow?(:users, :show)
# => false

user_authorization.allow?(:users, :show, user.id)
# => true
```

### `#allow`

This is what you use to set permissions. It takes two parameters, `group` and `permissions`, and a block.
All are optional and depend on how specific you want to be.

### `#allow?`

This is what you use to check permissions. It takes a `group` param, a `permission` param, and an optional `object`
param to evaluate in the block.


License
-------

MIT

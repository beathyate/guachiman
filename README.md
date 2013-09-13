Guachiman
=========

Basic Authorization gem. Based on [RailsCast #385 Authorization from Scratch](http://railscasts.com/episodes/385-authorization-from-scratch-part-1)
from Ryan Bates.

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

Run `rails g guachiman:install`

This will generate a `permission.rb` file in `app/models`.

Include `Guachiman::Permissible` in `ApplicationController` and implement a `current_user` method there.

```ruby
include Guachiman::Permissible

def current_user
  @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
end
```

You can also override these methods to handle failed authorizations for GET, non-AJAX requests:

```ruby
def not_authorized
  redirect_to root_path, alert: t('flashes.not_authorized')
end

def not_signed_in
  session[:next] = request.url
  redirect_to sign_in_path, alert: t('flashes.please_sign_in')
end
```

And you can also override this method to handle failed non-GET or AJAX requests:

```ruby
def render_unauthorized
  render text: "NO", status: :unauthorized
end
```

That's it, now you can describe your permissions in this way:

```ruby
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
    allow :sessions,   [:new, :create, :destroy]
    allow :identities, [:new, :create]
    allow :passwords,  [:new, :create]

    allow_param :user, [:name, :email, :password]
  end

  def member
    guest
    allow :identities, [:show, :edit, :update]
    allow :passwords,  [:edit, :update]
  end

  def admin
    allow_all!
  end
end
```

* `allow` takes a controller params key and an array of actions.
* `allow_param` takes a model params key and an array of attributes.
* `allow_all!` is a convinience method to allow all controlles, actions and parameteres.

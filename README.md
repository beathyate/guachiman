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
    allow :sessions, [:new, :create, :destroy]
    allow :users,    [:new, :create]

    allow_param :user, [:name, :email, :password]
  end

  def member
    guest
    allow :users, [:show, :edit, :update]
  end

  def admin
    allow_all!
  end
end
```

* `#allow` takes a **controller** params key or array of keys and an array of **actions**.
* `#allow_param` takes a **model** params key or array of keys and an array of **attributes**.
* `#allow_all!` is a convinience method to allow **all** controllers, actions and parameteres.

You can also go a bit further in the way you specify your permissions, if you override `current_resource`:

```ruby
class OrdersController < ApplicationController
...

private
  def current_resource
    @order ||= params[:id].present? ? Order.find(params[:id]) : Order.new
  end
end
```

The `current_resource` is passed to a block that needs to return a truthy object to allow the action.

```ruby
def guest
  allow :sessions, [:new, :create, :destroy]
  allow :users,    [:new, :create]
  allow :orders,   [:show, :edit, :update] do |order|
    order.accessible_by_token? request.cookies['cart_token']
  end

  allow_param :user, [:name, :email, :password]
end

def member
  guest

  allow :users,  [:show, :edit, :update] do |user|
    current_user == user
  end
  allow :orders, [:show, :edit, :update] do |order|
    order.accessible_by_user? user
  end
end
```
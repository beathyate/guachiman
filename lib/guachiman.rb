require 'guachiman/version'
require 'guachiman/permissions'
require 'guachiman/params'
require 'strong_parameters'

if defined? Rails
  require 'guachiman/rails/railtie'
  require 'guachiman/rails/permissible'

  ActiveRecord::Base.send :include, ActiveModel::ForbiddenAttributesProtection
end

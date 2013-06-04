require 'guachiman/version'
require 'guachiman/permissions'
require 'guachiman/params'

if defined? Rails
  require 'guachiman/rails/railtie'
  require 'guachiman/rails/permissible'
  require 'strong_parameters'
  require 'active_record'

  ActiveRecord::Base.send :include, ActiveModel::ForbiddenAttributesProtection
end

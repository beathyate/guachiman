require 'guachiman/version'
require 'guachiman/permissions'
require 'guachiman/params'

if defined? Rails
  require 'guachiman/rails/railtie'
  require 'guachiman/rails/permissible'

  ActiveRecord::Base.send :include, ActiveModel::ForbiddenAttributesProtection if defined? ActiveRecord
end

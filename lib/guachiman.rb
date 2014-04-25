require 'guachiman/version'
require 'guachiman/permissions'
require 'guachiman/params'

if defined? Rails
  require 'guachiman/rails/railtie'
  require 'guachiman/rails/permissible'
  require 'active_record'
end

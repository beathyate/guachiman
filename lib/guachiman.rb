require 'guachiman/version'
require 'guachiman/permissions'
require 'guachiman/strong_parameters'
require 'guachiman/params'

if defined? Rails
  require 'guachiman/rails/railtie'
  require 'guachiman/rails/permissible'
end

module Guachiman
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      desc 'Install guachiman'
      source_root File.expand_path '../templates', __FILE__

      def copy_permission_model
        template 'permission.rb', 'app/models/permission.rb'
      end
    end
  end
end

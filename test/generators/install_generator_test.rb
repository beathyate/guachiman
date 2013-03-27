require 'test_helper'
require 'rails/generators/test_case'
require 'generators/guachiman/install/install_generator'

class InstallGeneratorTest < Rails::Generators::TestCase
  DESTINATION = File.expand_path File.join(File.dirname(__FILE__), '..', '..', 'tmp')
  destination DESTINATION

  tests Guachiman::Generators::InstallGenerator
  setup :prepare_destination

  def prepare_destination
    FileUtils.mkdir_p "#{DESTINATION}/app"
    FileUtils.mkdir_p "#{DESTINATION}/app/models"
  end

  test 'create permission' do
    run_generator

    assert_file 'app/models/permission.rb', /Permission/
    assert_file 'app/models/permission.rb', /Guachiman::Permissions/
    assert_file 'app/models/permission.rb', /Guachiman::Params/
  end
end
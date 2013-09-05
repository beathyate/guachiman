require 'test_helper'
require 'rails/generators/test_case'
require 'generators/guachiman/install/install_generator'

class InstallGeneratorTest < Rails::Generators::TestCase
  DESTINATION = File.expand_path File.join(File.dirname(__FILE__), '..', '..', 'tmp')
  FileUtils.mkdir_p DESTINATION unless Dir.exists? DESTINATION

  destination DESTINATION

  tests Guachiman::Generators::InstallGenerator
  setup :prepare_destination

  def prepare_destination
    FileUtils.rm_r    "#{DESTINATION}/app" if Dir.exists? "#{DESTINATION}/app"
    FileUtils.mkdir_p "#{DESTINATION}/app"
    FileUtils.mkdir_p "#{DESTINATION}/app/models"
  end

  test 'create permission' do
    run_generator

    assert_file 'app/models/permission.rb' do |f|
      assert_match /class Permission/, f
      assert_match /include Guachiman::Permissions/, f
      assert_match /include Guachiman::Params/, f
      assert_match /initialize current_user/, f
    end
  end
end

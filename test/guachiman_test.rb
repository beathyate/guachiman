require 'test_helper'

class GuachimanTest < MiniTest::Unit::TestCase
  def setup
    guachiman_class = Class.new do
      include Guachiman

      def initialize(admin = false)
        if admin
          allow_all!
        else
          allow :group, :basic_permission
          allow :group, :block_permission do |object|
            object == 1
          end
        end
      end
    end

    @admin_authorization = guachiman_class.new(true)
    @guest_authorization = guachiman_class.new(false)
  end

  def test_admin_is_always_allowed
    assert @admin_authorization.allow_all?
    assert @admin_authorization.allow?(:any_group, :any_permission)
  end

  def test_basic_permission
    assert @guest_authorization.allow?(:group, :basic_permission)
    refute @guest_authorization.allow?(:group, :other_permission)
  end

  def test_block_permission
    refute @guest_authorization.allow?(:group, :block_permission)
    refute @guest_authorization.allow?(:group, :block_permission, 0)
    assert @guest_authorization.allow?(:group, :block_permission, 1)
  end
end

require 'test_helper'

class GuachimanTest < MiniTest::Unit::TestCase
  def setup
    guachiman_class = Class.new do
      include Guachiman

      def initialize(admin = false)
        if admin
          allow
        else
          allow :basic_group

          allow :block_group do |object|
            object == 1
          end

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
    assert @admin_authorization.allow?(:any_group, :any_permission)
  end

  def test_group_basic_rules
    refute @guest_authorization.allow?(:other_group, :any_permission)
    assert @guest_authorization.allow?(:basic_group, :any_permission)
  end

  def test_group_block_rules
    refute @guest_authorization.allow?(:block_group, :any_permission)
    refute @guest_authorization.allow?(:block_group, :any_permission, 0)
    assert @guest_authorization.allow?(:block_group, :any_permission, 1)
  end

  def test_permission_basic_rules
    refute @guest_authorization.allow?(:group, :other_permission)
    assert @guest_authorization.allow?(:group, :basic_permission)
  end

  def test_permission_block_rules
    refute @guest_authorization.allow?(:group, :block_permission)
    refute @guest_authorization.allow?(:group, :block_permission, 0)
    assert @guest_authorization.allow?(:group, :block_permission, 1)
  end
end

require "bundler/setup"
require "minitest/autorun"
require "guachiman"

class GuachimanTest < MiniTest::Test
  def setup
    @authorization = Class.new do
      include Guachiman

      def initialize(user = 1)
        allow :group, [:permission1, :permission2]

        allow :group, [:permission3, :permission4] do |object|
          object == user
        end
      end
    end.new

    p @authorization
  end

  def test_basic_rules
    refute @authorization.allow?(:group, :permission0)
    assert @authorization.allow?(:group, :permission1)
    assert @authorization.allow?(:group, :permission2)
  end

  def test_block_rules_without_object
    refute @authorization.allow?(:group, :permission3)
    refute @authorization.allow?(:group, :permission4)
  end

  def test_block_rules_with_bad_object
    refute @authorization.allow?(:group, :permission3, 0)
    refute @authorization.allow?(:group, :permission4, 0)
  end

  def test_block_rules_with_good_object
    assert @authorization.allow?(:group, :permission3, 1)
    assert @authorization.allow?(:group, :permission4, 1)
  end

  def test_allow_all
    refute @authorization.allow?(:group, :permission0)

    @authorization.instance_variable_set(:@allow_all, true)

    assert @authorization.allow?(:group, :permission0)
  end
end

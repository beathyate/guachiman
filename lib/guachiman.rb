require 'guachiman/version'

module Guachiman
  def allow_all!
    @_allow_all = true
  end

  def allow_all?
    @_allow_all
  end

  def rules
    @_rules ||= {}
  end

  def allow(groups, permissions, &block)
    Array(groups).each do |group|
      Array(permissions).each do |permission|
        rules[group] ||= {}
        rules[group][permission] = (block || true)
      end
    end
  end

  def allow?(group, permission, object = nil)
    if result = allow_all? || rules[group] && rules[group][permission]
      result == true || object && result.call(object)
    else
      false
    end
  end
end

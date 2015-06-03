require "guachiman/version"

module Guachiman
  def rules
    @rules ||= {}
  end

  def allow(group, *permissions, &block)
    Array(permissions).each do |permission|
      rules[group] ||= {}
      rules[group][permission] = (block || true)
    end
  end

  def allow?(group, permission, object = nil)
    if rule = rules[group] && rules[group][permission]
      rule == true || object && rule.call(object)
    else
      false
    end
  end
end

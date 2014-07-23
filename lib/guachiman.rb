require 'guachiman/version'

module Guachiman
  def rules
    @_rules ||= { nil => {} }
  end

  def allow(groups = nil, permissions = nil, &block)
    groups      = [groups]      unless groups.is_a?(Array)
    permissions = [permissions] unless permissions.is_a?(Array)

    groups.each do |group|
      permissions.each do |permission|
        rules[group] ||= {}
        rules[group][permission] = (block || true)
      end
    end
  end

  def allow?(group, permission, object = nil)
    rule = rules[nil][nil] || rules[group] && (rules[group][nil] || rules[group][permission])

    if rule
      rule == true || object && rule.call(object)
    else
      false
    end
  end
end

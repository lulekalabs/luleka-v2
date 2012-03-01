require "active_support/inflector"

class Hash
  def camelize
    dup.camelize!
  end

  def camelize!
    keys.each do |key|
      value = delete(key)
      value.camelize! if value.kind_of? Hash
      case key
      when Symbol then self[key.to_s.camelize(:lower).to_sym] = value
      when String then self[key.camelize(:lower)] = value
      end
    end
    self
  end
end
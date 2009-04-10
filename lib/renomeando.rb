module ActiveRecord
class Base
    # Humanize attributes
    def self.human_attribute_name(attr)
      @humanized_attributes ||= {}
      @humanized_attributes[attr.to_sym] || attr.humanize
    end
    def self.humanize_attributes(*args)
      @humanized_attributes = *args
    end
  end
end 
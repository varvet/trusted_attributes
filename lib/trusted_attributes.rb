require "trusted_attributes/version"

module TrustedAttributes
  class UntrustedAttributesError < StandardError
    def initialize(diff)
      @diff = diff
    end

    def message
      list = @diff.map { |attr| ":#{attr}" }.join(', ')
      "Some attributes that were sent are not trusted. Mark them as trusted by setting `trust #{list}`"
    end
  end

  def self.included(base)
    base.hide_action :accessible_attributes
    base.extend ClassMethods
    super
  end

  module ClassMethods
    def trust(*attributes)
      before_filter do |controller|
        controller.accessible_attributes.concat(attributes)
      end
    end
  end

  def accessible_attributes
    @_accessible_attributes ||= []
  end

private

  def trust(*attributes)
    accessible_attributes.concat(attributes)
  end

  def attributes
    return {} unless params[attributes_key]
    # Be helpful and raise an exception when non trusted attributes are sent
    unless Rails.env.production?
      diff = params[attributes_key].keys.map(&:to_sym) - accessible_attributes
      raise UntrustedAttributesError.new(diff) unless diff.empty?
    end

    params[attributes_key].slice(*accessible_attributes)
  end

  def attributes_key
    params["controller"].split('/').last.singularize
  end
end

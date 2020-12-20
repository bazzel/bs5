# frozen_string_literal: true

module Bs5
  class ToastContainerComponent < ViewComponent::Base
    def initialize(options = {})
      @options = options.symbolize_keys
    end

    def component_class
      class_names = Array(@options[:class])
      class_names << 'toast-container'
      class_names.compact.join(' ')
    end

    def render?
      content.present?
    end
  end
end

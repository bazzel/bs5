# frozen_string_literal: true

module Bs5
  class ButtonToolbarComponent < ViewComponent::Base
    def initialize(options = {})
      @options = options
    end

    def render?
      content.present?
    end

    def component_attributes
      default_options = { role: 'toolbar' }
      @options[:class] = Array(@options[:class])
      @options[:class] << 'btn-toolbar'

      @options.merge(default_options)
    end
  end
end

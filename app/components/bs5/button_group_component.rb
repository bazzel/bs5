# frozen_string_literal: true

module Bs5
  class ButtonGroupComponent < ViewComponent::Base
    SIZES = { small: :sm, large: :lg }.with_indifferent_access.freeze
    CLASS_PREFIX = 'btn-group'

    attr_reader :vertical, :size

    def initialize(options = {})
      @options = options.symbolize_keys
      @vertical = @options.delete(:vertical)
      @size = @options.delete(:size)
    end

    def render?
      content.present?
    end

    def component_attributes
      default_options = { role: 'group' }
      @options[:class] = component_class
      @options.merge(default_options)
    end

    private

    def component_class
      class_names = Array(@options[:class])
      class_names << vertical_class
      class_names << size_class
      class_names
    end

    def vertical_class
      @vertical ? "#{CLASS_PREFIX}-vertical" : CLASS_PREFIX
    end

    def size_class
      return unless size?

      [CLASS_PREFIX, SIZES[size]].join('-')
    end

    def size?
      !!size
    end
  end
end

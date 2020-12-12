# frozen_string_literal: true

module Bs5
  class SpinnerComponent < ViewComponent::Base
    STYLES = %i[primary secondary success danger warning info light dark].freeze
    SIZES = { small: :sm, large: :lg }.freeze

    attr_reader :text, :color, :size, :options

    include ActiveModel::Validations
    validates :color, style: true, if: -> { color }

    def initialize(options = {})
      @options = options.symbolize_keys

      @text = @options.delete(:text)
      @color = @options.delete(:color)&.to_sym
      @grow = @options.delete(:grow)
      @size = @options.delete(:size)&.to_sym
    end

    def before_render
      raise errors.full_messages.to_sentence if invalid?
    end

    def component_attributes
      options[:class] = component_class
      options[:role] = 'status'
      options
    end

    def component_class
      class_names = Array(options[:class])
      class_names << shape_class
      class_names << contextual_class
      class_names << size_class

      class_names.compact.join(' ')
    end

    private

    def shape_class
      grow? ? 'spinner-grow' : 'spinner-border'
    end

    def contextual_class
      "text-#{@color}" if color
    end

    def size_class
      return unless size?

      [shape_class, SIZES[size]].join('-')
    end

    def grow?
      !!@grow
    end

    def size?
      !!size
    end
  end
end

# frozen_string_literal: true

module Bs5
  class ToastComponent < ViewComponent::Base
    include ViewComponent::SlotableV2
    include ComponentsHelper
    using HashRefinement

    attr_reader :color

    renders_one :header, Bs5::Toast::HeaderComponent
    renders_one :body, Bs5::Toast::BodyComponent

    def initialize(options = {})
      @options = options.symbolize_keys
      @color = @options.delete(:color)
      @close_button = @options.fetch(:close_button, true)
      @data_options = @options.extract!(:animation, :autohide, :delay)
    end

    def header?
      !!header
    end

    def component_attributes
      default_options = {
        role: :alert,
        aria: { live: 'assertive', atomic: true },
        data: data_options
      }

      @options[:class] = component_class

      @options.merge(default_options)
    end

    def white_text?
      color? && color.in?(%i[primary secondary success danger dark])
    end

    private

    def data_options
      @data_options.prefix_keys_with_bs
    end

    def component_class
      class_names = Array(@options[:class])
      class_names << 'toast'
      class_names << contextual_class
      class_names.compact.join(' ')
    end

    def contextual_class
      return unless color?

      class_names = ['border-0']
      class_names << "bg-#{color}"
      class_names << 'text-white' if white_text?

      class_names
    end

    def color?
      !!color
    end

    def close_button?
      @close_button
    end
  end
end

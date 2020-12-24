# frozen_string_literal: true

module Bs5
  class DropdownComponent < ViewComponent::Base
    include ViewComponent::SlotableV2
    include ComponentsHelper
    using HashRefinement

    CLASS_PREFIX = 'dropdown'
    DIRECTIONS = {
      up: :dropup,
      end: :dropend,
      start: :dropstart
    }.with_indifferent_access.freeze

    renders_many :items, Bs5::Dropdown::ItemComponent
    attr_reader :title

    def initialize(content_or_options = nil, options = {})
      if content_or_options.is_a? Hash
        @options = content_or_options.symbolize_keys
      else
        @title = content_or_options
        @options = options.symbolize_keys
      end

      extract_options
    end

    private

    def extract_options
      @split = @options.delete(:split)
      @dark = @options.delete(:dark)
      @direction = @options.delete(:direction)
      @align = @options.delete(:align)

      extract_data_options
    end

    def extract_data_options
      @data_options = @options.extract!(:offset, :flip, :boundary, :reference, :display)
    end

    def single_button_options
      @options.merge(default_options)
    end

    def component_class
      class_names = split? ? ['btn-group'] : [CLASS_PREFIX]
      class_names << DIRECTIONS[@direction] if direction?

      class_names.join(' ')
    end

    def split_button_options
      @options.merge(default_button_options)
    end

    def split_button_toggle_options
      single_button_options.dup.tap do |h|
        h[:class] += ' dropdown-toggle-split'
      end
    end

    def split?
      !!@split
    end

    def dark?
      !!@dark
    end

    def direction?
      !!@direction
    end

    def dropstart?
      @direction == :start
    end

    def default_button_options
      { type: :button }
    end

    def default_options
      default_button_options.merge({
                                     data: default_data_options.merge(@data_options).prefix_keys_with_bs,
                                     aria: { expanded: false },
                                     class: "#{CLASS_PREFIX}-toggle"
                                   })
    end

    def default_data_options
      default_data_options = { toggle: :dropdown }

      default_data_options[:display] = 'static' if responsive_align?

      default_data_options
    end

    def dropdown_menu_classes
      class_names = ["#{CLASS_PREFIX}-menu"]
      class_names << "#{CLASS_PREFIX}-menu-dark" if dark?
      class_names << align_classes

      class_names.compact.join(' ')
    end

    def align_classes
      case @align
      when Symbol
        'dropdown-menu-end'
      when Hash
        responsive_align_classes
      end
    end

    def responsive_align_classes
      k, v = @align.first
      class_names = ["dropdown-menu-#{v}-#{k}"]
      class_names << 'dropdown-menu-end' if @align.with_indifferent_access.key?(:start)

      class_names
    end

    def responsive_align?
      @align.is_a? Hash
    end
  end
end

# frozen_string_literal: true

module Bs5
  class DropdownComponent < ViewComponent::Base # rubocop:disable Metrics/ClassLength
    include ViewComponent::SlotableV2
    include ComponentsHelper
    using HashRefinement

    CLASS_PREFIX = 'dropdown'
    CLASS_NAMES = {
      visually_hidden: 'visually-hidden',
      toggle_split: "#{CLASS_PREFIX}-toggle-split",
      toggle: "#{CLASS_PREFIX}-toggle",
      menu: "#{CLASS_PREFIX}-menu",
      menu_dark: "#{CLASS_PREFIX}-menu-dark",
      menu_end: "#{CLASS_PREFIX}-menu-end"
    }.freeze
    DIRECTIONS = {
      up: :dropup,
      end: :dropend,
      start: :dropstart
    }.with_indifferent_access.freeze
    DROPDOWN_OPTIONS = %i[offset flip boundary reference display].freeze

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

      extract_dropdown_options
    end

    def extract_dropdown_options
      @dropdown_options = @options.extract!(*DROPDOWN_OPTIONS)
    end

    def split_button_toggle
      bs5_button_tag(split_button_toggle_options) do
        tag.span('Toggle Dropdown', class: CLASS_NAMES[:visually_hidden])
      end
    end

    def split_button
      bs5_button_tag title, split_button_options
    end

    def single_button
      bs5_button_tag title, single_button_options
    end

    def menu_content
      if items.any?
        tag.ul(class: dropdown_menu_classes) { items.map(&method(:concat)) }
      else
        tag.div(content, class: dropdown_menu_classes)
      end
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
        h[:class] += " #{CLASS_NAMES[:toggle_split]}"
      end
    end

    %i[split dark direction].each do |name|
      define_method("#{name}?") do
        !instance_variable_get("@#{name}").nil?
      end
    end

    def dropstart?
      @direction == :start
    end

    def default_button_options
      { type: :button }
    end

    def default_options
      default_button_options.merge({
                                     data: default_data_options.merge(@dropdown_options).prefix_keys_with_bs,
                                     aria: { expanded: false },
                                     class: CLASS_NAMES[:toggle]
                                   })
    end

    def default_data_options
      { toggle: :dropdown }.tap do |h|
        h[:display] = 'static' if responsive_align?
      end
    end

    def dropdown_menu_classes
      class_names = [CLASS_NAMES[:menu]]
      class_names << CLASS_NAMES[:menu_dark] if dark?
      class_names << align_classes

      class_names.compact.join(' ')
    end

    def align_classes
      case @align
      when Symbol
        CLASS_NAMES[:menu_end]
      when Hash
        responsive_align_classes
      end
    end

    def responsive_align_classes
      k, v = @align.first
      class_names = ["#{CLASS_PREFIX}-menu-#{v}-#{k}"]
      class_names << CLASS_NAMES[:menu_end] if @align.with_indifferent_access.key?(:start)

      class_names
    end

    def responsive_align?
      @align.is_a? Hash
    end
  end
end

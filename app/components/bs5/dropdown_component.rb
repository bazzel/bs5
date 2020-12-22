# frozen_string_literal: true

module Bs5
  class DropdownComponent < ViewComponent::Base
    include ViewComponent::SlotableV2
    include ComponentsHelper
    CLASS_PREFIX = 'dropdown'

    renders_many :items, Bs5::Dropdown::ItemComponent
    attr_reader :title

    def initialize(content_or_options = nil, options = {})
      if content_or_options.is_a? Hash
        @options = content_or_options.symbolize_keys
      else
        @title = content_or_options
        @options = options.symbolize_keys
      end

      @split = @options.delete(:split)
      @dark = @options.delete(:dark)
    end

    private

    def single_button_options
      @options.merge(default_options)
    end

    def component_class
      split? ? 'btn-group' : CLASS_PREFIX
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

    def default_button_options
      { type: :button }
    end

    def default_options
      default_button_options.merge({
                                     data: { bs_toggle: :dropdown },
                                     aria: { expanded: false },
                                     class: "#{CLASS_PREFIX}-toggle"
                                   })
    end

    def dropdown_menu_classes
      class_names = ["#{CLASS_PREFIX}-menu"]
      class_names << "#{CLASS_PREFIX}-menu-dark" if dark?

      class_names.join(' ')
    end
  end
end

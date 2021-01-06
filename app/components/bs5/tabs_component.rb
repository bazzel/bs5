# frozen_string_literal: true

module Bs5
  class TabsComponent < ViewComponent::Base
    include ViewComponent::SlotableV2

    renders_many :items, Bs5::Tabs::ItemComponent

    def initialize(options = {})
      @options = options.symbolize_keys
      extract_options
    end

    def before_render
      items.each { |item| item.style = item_style }
    end

    private

    def extract_options
      @style = @options.delete(:style) || :pills
      @vertical = @options.delete(:vertical)
    end

    def vertical_container(&block)
      if vertical?
        tag.div(class: 'd-flex align-items-start') do
          capture(&block)
        end
      else
        capture(&block)
      end
    end

    def tablist_class
      class_names = Array(@options[:class])
      class_names << %w[nav]
      class_names << style_class
      class_names << vertical_class
      class_names.join(' ')
    end

    def style_class
      ["nav-#{@style}"]
    end

    def vertical_class
      return unless vertical?

      ['flex-column']
    end

    %i[vertical].each do |name|
      define_method("#{name}?") do
        !!instance_variable_get("@#{name}")
      end
    end

    def item_style
      @style.to_s.singularize
    end
  end
end

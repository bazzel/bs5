# frozen_string_literal: true

module Bs5
  module ComponentsHelper
    COMPONENTS = %w[accordion alert badge close_button breadcrumb button_tag button_to list_group].freeze

    COMPONENTS.each do |name|
      define_method("bs5_#{name}") do |*args, &block|
        clazz = "Bs5::#{name.classify}Component".constantize
        render_component(clazz, *args, &block)
      end
    end

    def bs5_tooltip(title, options = nil)
      default_options = { toggle: :tooltip }
      options = Hash(options).symbolize_keys.merge(default_options)
      {
        title: title,
        data: options
      }
    end

    def bs5_collapse(expanded: false, target: nil, controls: nil)
      data_options = { toggle: :collapse }
      data_options[:target] = target if target

      aria_options = { expanded: expanded }

      if controls
        aria_options[:controls] = controls
      elsif target&.start_with?('#')
        aria_options[:controls] = target.delete_prefix('#')
      else
        raise 'Please provide a controls option.'
      end

      {
        data: data_options,
        aria: aria_options
      }
    end

    private

    def render_component(component_clazz, *args)
      render component_clazz.new(*args) do |c|
        yield c if block_given?
      end
    end
  end
end

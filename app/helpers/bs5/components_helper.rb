# frozen_string_literal: true

module Bs5
  module ComponentsHelper
    using HashRefinement
    COMPONENTS = %w[accordion alert badge close_button breadcrumb button_tag button_to list_group].freeze

    COMPONENTS.each do |name|
      define_method("bs5_#{name}") do |*args, &block|
        clazz = "Bs5::#{name.classify}Component".constantize
        render_component(clazz, *args, &block)
      end
    end

    def bs5_tooltip(title, options = {})
      default_options = { toggle: :tooltip }
      options = options.symbolize_keys.merge(default_options)
      {
        title: title,
        data: options.prefix_keys_with_bs
      }
    end

    def bs5_popover(options = {})
      title = options.delete(:title)
      default_options = { toggle: :popover }
      options = options.symbolize_keys.merge(default_options)
      {
        title: title,
        data: options.prefix_keys_with_bs
      }.compact
    end

    def bs5_collapse(*args)
      CollapseService.new(*args).to_hash
    end

    private

    def render_component(component_clazz, *args)
      render component_clazz.new(*args) do |c|
        yield c if block_given?
      end
    end
  end
end

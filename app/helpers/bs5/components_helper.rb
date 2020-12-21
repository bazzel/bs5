# frozen_string_literal: true

module Bs5
  module ComponentsHelper
    COMPONENTS = %w[accordion alert badge breadcrumb button_group button_tag button_to button_toolbar close_button
                    dropdown list_group spinner toast toast_container].freeze

    COMPONENTS.each do |name|
      define_method("bs5_#{name}") do |*args, &block|
        clazz = "Bs5::#{name.classify}Component".constantize
        render_component(clazz, *args, &block)
      end
    end

    def bs5_tooltip(*args)
      TooltipService.new(*args).to_hash
    end

    def bs5_popover(*args)
      PopoverService.new(*args).to_hash
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

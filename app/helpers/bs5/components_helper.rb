# frozen_string_literal: true

module Bs5
  module ComponentsHelper
    COMPONENTS = %w[accordion alert badge close_button breadcrumb button_tag].freeze

    COMPONENTS.each do |name|
      define_method("bs5_#{name}") do |*args, &block|
        clazz = "Bs5::#{name.classify}Component".constantize
        render_component(clazz, *args, &block)
      end
    end

    private

    def render_component(component_clazz, *args)
      render component_clazz.new(*args) do |c|
        yield c if block_given?
      end
    end
  end
end

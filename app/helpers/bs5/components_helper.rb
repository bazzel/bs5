# frozen_string_literal: true

module Bs5
  module ComponentsHelper
    COMPONENTS = %w[accordion alert badge close_button breadcrumb].freeze

    COMPONENTS.each do |name|
      define_method("bs5_#{name}") do |*args, &block|
        clazz = "Bs5::#{name.classify}Component".constantize
        render_component(clazz, *args, &block)
      end
    end

    # def bs5_button_tag(content_or_options = nil, options = nil, &block)
    #   if content_or_options.is_a? Hash
    #     content_or_options.merge!(class: 'btn btn-primary')
    #   else
    #     options ||= {}
    #     options.merge!(class: 'btn btn-primary')
    #   end

    #   button_tag(content_or_options, options, &block)
    # end

    private

    def render_component(component_clazz, *args)
      render component_clazz.new(*args) do |c|
        yield c if block_given?
      end
    end
  end
end

# frozen_string_literal: true

module Bs5
  module ComponentsHelper
    def bs5_accordion(*args, &block)
      render_component(AccordionComponent, *args, &block)
    end

    def bs5_alert(*args, &block)
      render_component(AlertComponent, *args, &block)
    end

    def bs5_badge(*args, &block)
      render_component(BadgeComponent, *args, &block)
    end

    def bs5_close_button(*args, &block)
      render_component(CloseButtonComponent, *args, &block)
    end

    def bs5_breadcrumb(*args, &block)
      render_component(BreadcrumbComponent, *args, &block)
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

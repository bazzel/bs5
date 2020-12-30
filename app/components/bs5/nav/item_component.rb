# frozen_string_literal: true

module Bs5
  module Nav
    class ItemComponent < ViewComponent::Base
      def initialize(options = {})
        @options = options.symbolize_keys
        extract_options
      end

      private

      def extract_options
        @active = @options.delete(:active)
        @disabled = @options.delete(:disabled)
      end

      def content
        set_element_attributes
        element.to_html.html_safe # rubocop:disable Rails/OutputSafety
      end

      def set_element_attributes
        element['aria-current'] = 'page' if active?

        if disabled?
          element['aria-disabled'] = true
          element['tabindex'] = -1
        end

        set_element_class_names
      end

      def set_element_class_names
        class_names = Array(element[:class])
        class_names << element_classes
        class_names << active_class
        class_names << disabled_class
        element[:class] = class_names.compact.uniq.join(' ')
      end

      def element_classes
        %w[nav-link]
      end

      def active_class
        return unless active?

        %w[active]
      end

      def disabled_class
        return unless disabled?

        %w[disabled]
      end

      def element
        @element ||= begin
          if (elements = Nokogiri::HTML::DocumentFragment.parse(@content).elements).one?
            elements.first
          end
        end
      end

      %i[active disabled].each do |name|
        define_method("#{name}?") do
          !!instance_variable_get("@#{name}")
        end
      end
    end
  end
end

# frozen_string_literal: true

module Bs5
  module Carousel
    class ItemComponent < ViewComponent::Base
      attr_accessor :active

      def active?
        active
      end

      def content
        set_element_class_names
        element.to_html.html_safe # rubocop:disable Rails/OutputSafety
      end

      def set_element_class_names
        class_names = Array(element[:class])
        class_names << item_classes
        element[:class] = class_names.join(' ')
      end

      def item_classes
        %w[d-block w-100]
      end

      def element
        @element ||= begin
          if (elements = Nokogiri::HTML::DocumentFragment.parse(@content).elements).one?
            elements.first
          end
        end
      end

      def element?
        !!element
      end
    end
  end
end

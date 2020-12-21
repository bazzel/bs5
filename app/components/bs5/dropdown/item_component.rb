# frozen_string_literal: true

module Bs5
  module Dropdown
    class ItemComponent < ViewComponent::Base
      private

      def content
        return nil if @content.blank?

        set_actionable_element_class_names
        actionable_element.to_html.html_safe # rubocop:disable Rails/OutputSafety
      end

      def set_actionable_element_class_names
        class_names = Array(actionable_element[:class])
        class_names << 'dropdown-item'
        actionable_element[:class] = class_names.join(' ')
      end

      def actionable_element
        @actionable_element ||= begin
          if (elements = Nokogiri::HTML::DocumentFragment.parse(@content).elements).one? &&
             (element = elements.first).name.in?(%w[a])
            element
          end
        end
      end
    end
  end
end

# frozen_string_literal: true

module Bs5
  module Modal
    class ControllerComponent < ViewComponent::Base
      def initialize(modal_id:)
        @modal_id = modal_id
      end

      def content
        return nil if @content.blank?

        if actionable_element?
          set_actionable_element_attributes
          actionable_element.to_html.html_safe # rubocop:disable Rails/OutputSafety
        else
          @content
        end
      end

      def set_actionable_element_attributes
        actionable_element['data-bs-toggle'] = 'modal'
        actionable_element['data-bs-target'] = "##{@modal_id}"
      end

      def actionable_element
        @actionable_element ||= begin
          if (elements = Nokogiri::HTML::DocumentFragment.parse(@content).elements).one? &&
             (element = elements.first).name.in?(%w[a button])
            element
          end
        end
      end

      def actionable_element?
        !!actionable_element
      end
    end
  end
end

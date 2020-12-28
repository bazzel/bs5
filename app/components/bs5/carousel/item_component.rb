# frozen_string_literal: true

module Bs5
  module Carousel
    class ItemComponent < ViewComponent::Base
      include ViewComponent::SlotableV2
      using HashRefinement

      COMPONENT_OPTIONS = %i[interval].freeze

      renders_one :caption, Bs5::Carousel::CaptionComponent

      attr_accessor :active

      def initialize(options = {})
        @options = options.symbolize_keys
        extract_options
      end

      def active?
        active
      end

      private

      def extract_options
        extract_component_options
      end

      def extract_component_options
        @component_options = @options.extract!(*COMPONENT_OPTIONS)
      end

      def component_attributes
        { class: component_classes,
          data: @component_options.prefix_keys_with_bs }
      end

      def component_classes
        class_names = %w[carousel-item]
        class_names << 'active' if active?

        class_names
      end

      def content
        set_element_class_names
        element.to_html.html_safe # rubocop:disable Rails/OutputSafety
      end

      def set_element_class_names
        class_names = Array(element[:class])
        class_names << element_classes
        element[:class] = class_names.join(' ')
      end

      def element_classes
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

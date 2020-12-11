# frozen_string_literal: true

module Bs5
  class AccordionComponent < ViewComponent::Base
    include ComponentsHelper
    include ViewComponent::SlotableV2

    renders_many :items, 'ItemComponent'

    def initialize(flush: false)
      @flush = flush
    end

    def flush?
      @flush
    end

    def id
      "accordion-#{object_id}"
    end

    def component_class
      class_names = ['accordion']
      class_names << %w[accordion-flush] if flush?
      class_names.join(' ')
    end

    class ItemComponent < ViewComponent::Base
      attr_reader :title

      def initialize(title:, collapsed: true)
        @title = title
        @collapsed = collapsed
      end

      def call
        content
      end

      def id
        object_id
      end

      def header_id
        "header-#{id}"
      end

      def collapse_id
        "collapse-#{id}"
      end

      def collapsed?
        @collapsed
      end

      def button_class
        class_names = ['accordion-button']
        class_names << %w[collapsed] if collapsed?
        class_names.join(' ')
      end

      def collapse_class
        class_names = %w[accordion-collapse collapse]
        class_names << %w[show] unless collapsed?
        class_names.join(' ')
      end
    end
  end
end

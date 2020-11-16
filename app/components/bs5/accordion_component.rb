# frozen_string_literal: true

module Bs5
  class AccordionComponent < ViewComponent::Base
    include ViewComponent::Slotable

    with_slot :item, collection: true, class_name: 'Item'

    def initialize(flush: false)
      @flush = flush
    end

    def flush?
      @flush
    end

    def id
      "accordion-#{object_id}"
    end

    class Item < ViewComponent::Slot
      attr_reader :title

      def initialize(title:, collapsed: true)
        @title = title
        @collapsed = collapsed
      end

      def id
        object_id
      end

      def heading_id
        "heading-#{id}"
      end

      def collapse_id
        "collapse-#{id}"
      end

      def collapsed?
        @collapsed
      end
    end
  end
end

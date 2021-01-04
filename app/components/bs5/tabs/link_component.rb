# frozen_string_literal: true

module Bs5
  module Tabs
    class LinkComponent < ViewComponent::Base
      attr_reader :item

      def initialize(item)
        @item = item
      end

      def component_class
        class_names = ['nav-link']

        class_names << active_class

        class_names.compact.join(' ')
      end

      def active_class
        return unless item.active?

        %w[active]
      end
    end
  end
end

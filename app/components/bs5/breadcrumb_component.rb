# frozen_string_literal: true

module Bs5
  class BreadcrumbComponent < ViewComponent::Base
    include ViewComponent::SlotableV2

    renders_many :items, 'ItemComponent'

    class ItemComponent < ViewComponent::Base
      def call
        content
      end
    end
  end
end

# frozen_string_literal: true

module Bs5
  class BreadcrumbComponent < ViewComponent::Base
    include ViewComponent::Slotable

    with_slot :item, collection: true, class_name: 'Item'

    class Item < ViewComponent::Slot
    end
  end
end

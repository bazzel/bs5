# frozen_string_literal: true

module Bs5
  class NavComponent < ViewComponent::Base
    include ViewComponent::SlotableV2

    renders_many :items, Bs5::Nav::ItemComponent
  end
end

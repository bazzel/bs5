# frozen_string_literal: true

module Bs5
  class CarouselComponent < ViewComponent::Base
    include ComponentsHelper
    include ViewComponent::SlotableV2

    renders_many :items, Bs5::Carousel::ItemComponent
  end
end

# frozen_string_literal: true

module Bs5
  class ToastComponent < ViewComponent::Base
    include ViewComponent::SlotableV2
    renders_one :header, Bs5::Toast::HeaderComponent
    renders_one :body, Bs5::Toast::BodyComponent
  end
end

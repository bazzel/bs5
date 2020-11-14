# frozen_string_literal: true

module Bs5
  class AlertComponent < ViewComponent::Base
    def initialize(type: :primary)
      @type = type
    end

    private

    def contextual_class
      "alert-#{@type}"
    end
  end
end

# frozen_string_literal: true

module Bs5
  class ProgressComponent < ViewComponent::Base
    include ViewComponent::SlotableV2
    renders_many :bars, Bs5::Progress::BarComponent

    attr_reader :value, :options

    def initialize(value = nil, options = {})
      @options = options.symbolize_keys
      @value = value
    end
  end
end

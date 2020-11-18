# frozen_string_literal: true

module Bs5
  class CloseButtonComponent < ViewComponent::Base
    attr_reader :data

    def initialize(disabled: false, white: false, data: nil)
      @disabled = disabled
      @white = white
      @data = data
    end

    private

    def white?
      @white
    end

    def disabled?
      @disabled
    end

    def component_class
      class_names = ['btn-close']
      class_names << %w[btn-close-white] if white?
      class_names.join(' ')
    end
  end
end

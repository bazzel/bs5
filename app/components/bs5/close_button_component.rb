# frozen_string_literal: true

module Bs5
  class CloseButtonComponent < ViewComponent::Base
    def initialize(options = {})
      @options = options.symbolize_keys

      @disabled = options.delete(:disabled)
      @white = options.delete(:white)
      @dismiss = options.delete(:dismiss)
      @data = options.fetch(:data, {})
    end

    def data
      @data['bs-dismiss'] = @dismiss if @dismiss

      @data
    end

    private

    def white?
      @white
    end

    def disabled?
      @disabled
    end

    def component_class
      class_names = Array(@options[:class])
      class_names << 'btn-close'
      class_names << %w[btn-close-white] if white?
      class_names.join(' ')
    end
  end
end

# frozen_string_literal: true

module Bs5
  class TooltipService
    using HashRefinement

    attr_reader :title

    def initialize(title, options = {})
      @title = title
      @options = options
    end

    def to_hash
      {
        title: title,
        data: options
      }
    end

    private

    def options
      @options.symbolize_keys.merge(default_options).prefix_keys_with_bs
    end

    def default_options
      { toggle: :tooltip }
    end
  end
end

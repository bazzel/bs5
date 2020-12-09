# frozen_string_literal: true

module Bs5
  class PopoverService
    using HashRefinement

    attr_reader :title

    def initialize(options = {})
      @title = options.delete(:title)
      @options = options
    end

    def to_hash
      {
        title: title,
        data: options
      }.compact
    end

    private

    def options
      @options.symbolize_keys.merge(default_options).prefix_keys_with_bs
    end

    def default_options
      { toggle: :popover }
    end
  end
end

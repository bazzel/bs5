# frozen_string_literal: true

module Bs5
  class ButtonTagComponent < ViewComponent::Base
    attr_reader :content_or_options, :options

    def initialize(content_or_options = nil, options = nil)
      if content_or_options.is_a? Hash
        with_defaults! content_or_options
      else
        options ||= {}
        with_defaults! options
      end

      @content_or_options = content_or_options
      @options = options
    end

    def call
      if content
        button_tag(content_or_options, options) { content }
      else
        button_tag(content_or_options, options)
      end
    end

    private
    def with_defaults!(hash)
      hash.merge! default_options
    end

    def default_options
      {
        class: 'btn btn-primary'
      }
    end
  end
end

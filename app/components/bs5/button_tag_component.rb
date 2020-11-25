# frozen_string_literal: true

module Bs5
  class ButtonTagComponent < ViewComponent::Base
    STYLES = %i[primary secondary success danger warning info light dark link].freeze

    attr_reader :content_or_options, :options

    include ActiveModel::Validations
    validates :style, style: true

    def initialize(content_or_options = nil, options = nil)
      @content_or_options = content_or_options.dup
      @options = options.dup

      extract_style
      merge_default_options
    end

    def before_render
      raise errors.full_messages.to_sentence if invalid?
    end

    def call
      if content
        button_tag(content_or_options, options) { content }
      else
        button_tag(content_or_options, options)
      end
    end

    private

    def extract_style
      if @content_or_options.is_a? Hash
        @style = @content_or_options.delete(:style)
        @content_or_options = nil if @content_or_options.empty?
      elsif @options.is_a? Hash
        @style = @options.delete(:style)
        @options = nil if @options.empty?
      end
    end

    def merge_default_options
      if @content_or_options.is_a? Hash
        @content_or_options.merge! default_options
      else
        @options ||= {}
        @options.merge! default_options
      end
    end

    def default_options
      {
        class: button_class
      }
    end

    def button_class
      ['btn', contextual_class]
    end

    def contextual_class
      "btn-#{style}"
    end

    def style
      (@style || 'primary').to_sym
    end
  end
end

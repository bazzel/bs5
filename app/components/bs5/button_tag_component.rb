# frozen_string_literal: true

module Bs5
  class ButtonTagComponent < ViewComponent::Base
    STYLES = %i[primary secondary success danger warning info light dark link].freeze
    SIZES = %i[small large].freeze

    attr_reader :content_or_options, :options, :size

    include ActiveModel::Validations
    validates :style, style: true
    validates :size, inclusion: { in: SIZES, valid_sizes: SIZES.to_sentence, allow_nil: true }

    def initialize(content_or_options = nil, options = nil)
      @content_or_options = content_or_options.dup
      @options = options.dup

      extract_custom_options
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

    def extract_custom_options
      extract_style
      extract_outline
      extract_size
    end

    def extract_style
      if @content_or_options.is_a? Hash
        @style = @content_or_options.delete(:style)
        @content_or_options = nil if @content_or_options.empty?
      elsif @options.is_a? Hash
        @style = @options.delete(:style)
        @options = nil if @options.empty?
      end
    end

    def extract_outline
      if @content_or_options.is_a? Hash
        @outline = @content_or_options.delete(:outline)
        @content_or_options = nil if @content_or_options.empty?
      elsif @options.is_a? Hash
        @outline = @options.delete(:outline)
        @options = nil if @options.empty?
      end
    end

    def extract_size
      if @content_or_options.is_a? Hash
        @size = @content_or_options.delete(:size)
        @content_or_options = nil if @content_or_options.empty?
      elsif @options.is_a? Hash
        @size = @options.delete(:size)
        @options = nil if @options.empty?
      end
    end

    def merge_default_options
      if @content_or_options.is_a? Hash
        deep_merge_and_join @content_or_options, default_options
      else
        @options ||= {}
        deep_merge_and_join @options, default_options
      end
    end

    def default_options
      {
        class: button_class
      }
    end

    def button_class
      ['btn', contextual_class, size_class].compact.join(' ')
    end

    def contextual_class
      ['btn', outline? ? 'outline' : nil, style].compact.join('-')
    end

    def size_class
      return unless size?

      x = { large: 'lg', small: 'sm' }[@size]

      "btn-#{x}"
    end

    def style
      (@style || 'primary').to_sym
    end

    def outline?
      !!@outline
    end

    def size?
      !!@size
    end

    def deep_merge_and_join(h1, h2)
      h1.deep_merge!(h2) do |key, this_val, other_val|
        [this_val, other_val].join(' ').strip
      end
    end
  end
end

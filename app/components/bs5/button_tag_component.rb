# frozen_string_literal: true

module Bs5
  class ButtonTagComponent < ViewComponent::Base
    STYLES = %i[primary secondary success danger warning info light dark link].freeze
    DEFAULT_COLOR = :primary
    SIZES = { small: :sm, large: :lg }.freeze
    CLASS_PREFIX = 'btn'

    attr_reader :content_or_options, :size

    include ActiveModel::Validations
    validates :color, style: true
    validates :size, inclusion: { in: SIZES.keys, valid_sizes: SIZES.keys.to_sentence, allow_nil: true }

    def initialize(content_or_options = nil, options = nil)
      if content_or_options.is_a? Hash
        self.options = content_or_options
      else
        @content_or_options = content_or_options
        self.options = options
      end

      extract_custom_options
      merge_default_options
    end

    def before_render
      raise errors.full_messages.to_sentence if invalid?
    end

    def call
      button_tag(content || content_or_options, options)
    end

    private

    def options=(value)
      @options = Hash(value).symbolize_keys!
    end

    def options
      @options.empty? ? nil : @options
    end

    def extract_custom_options
      extract_color
      extract_outline
      extract_size
    end

    def extract_color
      @color = @options.delete(:color)
    end

    def extract_outline
      @outline = @options.delete(:outline)
    end

    def extract_size
      @size = @options.delete(:size)
    end

    def merge_default_options
      @options.deep_merge!(default_options) do |_key, this_val, other_val|
        [this_val, other_val].join(' ').strip
      end
    end

    def default_options
      { class: button_class }
    end

    def button_class
      [CLASS_PREFIX, contextual_class, size_class].compact.join(' ')
    end

    def contextual_class
      [CLASS_PREFIX, outline? ? 'outline' : nil, color].compact.join('-')
    end

    def size_class
      return unless size?

      [CLASS_PREFIX, SIZES[size]].join('-')
    end

    def color
      (@color || DEFAULT_COLOR).to_sym
    end

    def outline?
      !!@outline
    end

    def size?
      !!size
    end
  end
end

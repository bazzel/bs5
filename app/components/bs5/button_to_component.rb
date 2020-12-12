# frozen_string_literal: true

module Bs5
  class ButtonToComponent < ViewComponent::Base
    STYLES = %i[primary secondary success danger warning info light dark link].freeze
    DEFAULT_COLOR = :primary
    SIZES = { small: :sm, large: :lg }.freeze
    CLASS_PREFIX = 'btn'

    attr_reader :size

    include ActiveModel::Validations
    validates :color, style: true
    validates :size, inclusion: { in: SIZES.keys, valid_sizes: SIZES.keys.to_sentence, allow_nil: true }

    def initialize(name = nil, options = nil, html_options = nil)
      @name = name
      @options = options
      @html_options = html_options

      set_button_to_options
      extract_custom_options
      merge_default_options
    end

    def before_render
      raise errors.full_messages.to_sentence if invalid?
    end

    def call
      if content
        button_to(@name, @options, @html_options) { content }
      else
        button_to(@name, @options, @html_options)
      end
    end

    private

    def set_button_to_options
      if @name.is_a? Hash
        self.button_to_options = @name
      elsif @options.is_a? Hash
        self.button_to_options = @options
      else
        @html_options ||= {}
        self.button_to_options = @html_options
      end
    end

    def button_to_options=(hash)
      @button_to_options = hash.symbolize_keys!
    end

    def extract_custom_options
      extract_color
      extract_outline
      extract_size
    end

    def extract_color
      @color = @button_to_options.delete(:color)
    end

    def extract_outline
      @outline = @button_to_options.delete(:outline)
    end

    def extract_size
      @size = @button_to_options.delete(:size)
    end

    def merge_default_options
      @button_to_options.deep_merge!(default_options) do |_key, this_val, other_val|
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

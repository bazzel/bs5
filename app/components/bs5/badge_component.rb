# frozen_string_literal: true

module Bs5
  class BadgeComponent < ViewComponent::Base
    TYPES = %i[primary secondary success danger warning info light dark].freeze

    include ActiveModel::Validations

    attr_reader :text, :type

    validates :type, inclusion: { in: TYPES, message: lambda do |_, data|
      "#{data[:value].inspect} is not valid. Try #{TYPES.to_sentence(last_word_connector: ' or ')}."
    end }

    def initialize(text:, type: :secondary, pill: false)
      @text = text
      @type = type.to_sym
      @pill = pill
    end

    def before_render
      raise errors.full_messages.to_sentence if invalid?
    end

    private

    def component_class
      class_names = ['badge', contextual_class]
      class_names << %w[rounded-pill] if pill?
      class_names.join(' ')
    end

    def pill?
      @pill
    end

    def contextual_class
      class_names = ["bg-#{@type}"]
      class_names << %w[text-dark] if type.in?(%i[warning info light])
      class_names.join(' ')
    end
  end
end

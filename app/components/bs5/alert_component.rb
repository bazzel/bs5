# frozen_string_literal: true

module Bs5
  class AlertComponent < ViewComponent::Base
    TYPES = %i[primary secondary success danger warning info light dark].freeze

    include ActiveModel::Validations

    attr_reader :type, :is_dismissable

    validates :type, inclusion: { in: TYPES, message: lambda do |_, data|
      "#{data[:value].inspect} is not valid. Try #{TYPES.to_sentence(last_word_connector: ' or ')}."
    end }

    def initialize(type: :primary, is_dismissable: false)
      @type = type.to_sym
      @is_dismissable = is_dismissable
    end

    def before_render
      raise errors.full_messages.to_sentence if invalid?
    end

    def render?
      content.present?
    end

    private

    def component_class
      class_names = ['alert', contextual_class]
      class_names << %w[alert-dismissible fade show] if is_dismissable
      class_names.join(' ')
    end

    def contextual_class
      "alert-#{@type}"
    end
  end
end

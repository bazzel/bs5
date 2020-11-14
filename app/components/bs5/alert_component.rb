# frozen_string_literal: true

module Bs5
  class AlertComponent < ViewComponent::Base
    TYPES = %i[primary secondary success danger warning info light dark].freeze

    include ActiveModel::Validations

    attr_reader :type

    validates :type, inclusion: { in: TYPES, message: lambda do |_object, data|
      "#{data[:value].inspect} is not valid. Try #{TYPES.to_sentence(last_word_connector: ' or ')}."
    end }

    def initialize(type: :primary)
      @type = type.to_sym
    end

    def before_render
      raise errors.full_messages.to_sentence if invalid?
    end

    private

    def contextual_class
      "alert-#{@type}"
    end
  end
end

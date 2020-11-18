# frozen_string_literal: true

module Bs5
  class AlertComponent < ViewComponent::Base
    attr_reader :style, :is_dismissable

    include ActiveModel::Validations
    validates :style, style: true

    def initialize(style: :primary, is_dismissable: false)
      @style = style.to_sym
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
      "alert-#{@style}"
    end
  end
end

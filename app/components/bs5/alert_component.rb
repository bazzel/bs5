# frozen_string_literal: true

module Bs5
  class AlertComponent < ViewComponent::Base
    include ComponentsHelper
    STYLES = %i[primary secondary success danger warning info light dark].freeze

    attr_reader :color, :is_dismissable

    include ActiveModel::Validations
    validates :color, style: true

    def initialize(color: :primary, is_dismissable: false)
      @color = color.to_sym
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
      "alert-#{@color}"
    end
  end
end

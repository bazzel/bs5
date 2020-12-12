# frozen_string_literal: true

module Bs5
  class BadgeComponent < ViewComponent::Base
    STYLES = %i[primary secondary success danger warning info light dark].freeze

    attr_reader :text, :color

    include ActiveModel::Validations
    validates :color, style: true

    def initialize(text:, color: :secondary, pill: false)
      @text = text
      @color = color.to_sym
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
      class_names = ["bg-#{@color}"]
      class_names << %w[text-dark] if color.in?(%i[warning info light])
      class_names.join(' ')
    end
  end
end

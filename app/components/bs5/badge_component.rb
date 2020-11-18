# frozen_string_literal: true

module Bs5
  class BadgeComponent < ViewComponent::Base
    attr_reader :text, :style

    include ActiveModel::Validations
    validates :style, style: true

    def initialize(text:, style: :secondary, pill: false)
      @text = text
      @style = style.to_sym
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
      class_names = ["bg-#{@style}"]
      class_names << %w[text-dark] if style.in?(%i[warning info light])
      class_names.join(' ')
    end
  end
end

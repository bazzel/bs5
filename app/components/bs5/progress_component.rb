# frozen_string_literal: true

module Bs5
  class ProgressComponent < ViewComponent::Base
    # include ComponentsHelper
    # STYLES = %i[primary secondary success danger warning info light dark].freeze

    attr_reader :value

    # include ActiveModel::Validations
    # validates :color, style: true

    def initialize(value)
      @value = value
    end

    # def before_render
    #   raise errors.full_messages.to_sentence if invalid?
    # end

    # def render?
    #   content.present?
    # end

    # def component_class
    #   class_names = Array(@options[:class])
    #   class_names << 'progress'
    #   class_names.join(' ')
    # end

    # def contextual_class
    #   "alert-#{@color}"
    # end
  end
end

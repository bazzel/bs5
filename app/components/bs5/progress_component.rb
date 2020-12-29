# frozen_string_literal: true

module Bs5
  class ProgressComponent < ViewComponent::Base
    # include ComponentsHelper
    # STYLES = %i[primary secondary success danger warning info light dark].freeze

    attr_reader :value, :color

    # include ActiveModel::Validations
    # validates :color, style: true

    def initialize(value, label: nil, color: nil)
      @value = value
      @label = label
      @color = color
    end

    def label
      return unless @label

      case @label
      when String
        @label
      else
        "#{value}%"
      end
    end
    # def before_render
    #   raise errors.full_messages.to_sentence if invalid?
    # end

    # def render?
    #   content.present?
    # end

    def bar_class
      class_names = %w[progress-bar]
      class_names << contextual_class
      class_names.join(' ')
    end

    def contextual_class
      return unless color?

      "bg-#{color}"
    end

    %i[color].each do |name|
      define_method("#{name}?") do
        !instance_variable_get("@#{name}").nil?
      end
    end
  end
end

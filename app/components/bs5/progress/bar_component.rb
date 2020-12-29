# frozen_string_literal: true

module Bs5
  module Progress
    class BarComponent < ViewComponent::Base
      attr_reader :value, :color

      def initialize(value, label: nil, color: nil, striped: false, animated: false)
        @value = value
        @label = label
        @color = color
        @striped = striped
        @animated = animated
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

      def bar_class
        class_names = %w[progress-bar]
        class_names << contextual_class
        class_names << striped_class
        class_names << animated_class
        class_names.flatten.uniq.join(' ')
      end

      def contextual_class
        return unless color?

        "bg-#{color}"
      end

      def striped_class
        return unless striped?

        'progress-bar-striped'
      end

      def animated_class
        return unless animated?

        %w[progress-bar-striped progress-bar-animated]
      end

      %i[color striped animated].each do |name|
        define_method("#{name}?") do
          !!instance_variable_get("@#{name}")
        end
      end
    end
  end
end

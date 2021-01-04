# frozen_string_literal: true

module Bs5
  module Tabs
    class ItemComponent < ViewComponent::Base
      attr_reader :title, :options

      def initialize(title, options = {})
        @title = title
        @options = options.symbolize_keys
        extract_options
      end

      def tab_id
        "nav-#{object_id}-tab"
      end

      def pane_id
        "nav-#{object_id}"
      end

      %i[active].each do |name|
        define_method("#{name}?") do
          !!instance_variable_get("@#{name}")
        end
      end

      private

      def extract_options
        @active = @options.delete(:active)
      end

      def component_class
        class_names = %w[tab-pane fade]
        class_names << active_class
        class_names.join(' ')
      end

      def active_class
        return unless active?

        %w[show active]
      end
    end
  end
end

# frozen_string_literal: true

module Bs5
  class NavComponent < ViewComponent::Base
    include ViewComponent::SlotableV2

    renders_many :items, Bs5::Nav::ItemComponent

    def initialize(options = {})
      @options = options.symbolize_keys
      extract_options
    end

    private

    def extract_options
      @style = @options.delete(:style)
      @space = @options.delete(:space)
    end

    def component_class
      class_names = Array(@options[:class])
      class_names << ['nav']
      class_names << style_class
      class_names << space_class
      class_names.join(' ')
    end

    def style_class
      return unless style?

      ["nav-#{@style}"]
    end

    def space_class
      return unless space?

      ["nav-#{@space}"]
    end

    %i[style space].each do |name|
      define_method("#{name}?") do
        !!instance_variable_get("@#{name}")
      end
    end
  end
end

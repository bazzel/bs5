# frozen_string_literal: true

module Bs5
  class TabsComponent < ViewComponent::Base
    include ViewComponent::SlotableV2

    renders_many :items, Bs5::Tabs::ItemComponent

    def initialize(options = {})
      @options = options.symbolize_keys
      extract_options
    end

    private

    def extract_options
      @style = @options.fetch(:style, :tabs)
    end

    def tablist_class
      class_names = Array(@options[:class])
      class_names << %w[nav]
      class_names << style_class
      class_names.join(' ')
    end

    def style_class
      ["nav-#{@style}"]
    end
  end
end

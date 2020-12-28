# frozen_string_literal: true

module Bs5
  class CarouselComponent < ViewComponent::Base
    include ComponentsHelper
    include ViewComponent::SlotableV2

    renders_many :items, Bs5::Carousel::ItemComponent

    def initialize(options = {})
      @options = options.symbolize_keys
      extract_options
    end

    private

    def extract_options
      @controls = @options.delete(:controls)
      @indicators = @options.delete(:indicators)
      @crossfade = @options.delete(:crossfade)

      # extract_carousel_options
    end

    def id
      "carousel-#{object_id}"
    end

    def items_count
      items.size
    end

    def component_class
      class_names = %w[carousel slide]
      class_names << %w[carousel-fade] if crossfade?
      class_names.join(' ')
    end

    %i[controls indicators crossfade].each do |name|
      define_method("#{name}?") do
        !instance_variable_get("@#{name}").nil?
      end
    end
  end
end

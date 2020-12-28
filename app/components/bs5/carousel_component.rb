# frozen_string_literal: true

module Bs5
  class CarouselComponent < ViewComponent::Base
    include ComponentsHelper
    include ViewComponent::SlotableV2
    using HashRefinement

    CAROUSEL_OPTIONS = %i[interval keyboard pause slide wrap touch].freeze

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
      @dark = @options.delete(:dark)

      extract_carousel_options
    end

    def extract_carousel_options
      @carousel_options = @options.extract!(*CAROUSEL_OPTIONS)
    end

    def id
      "carousel-#{object_id}"
    end

    def items_count
      items.size
    end

    def component_attributes
      { class: component_class,
        id: id,
        data: @carousel_options.merge(ride: :carousel).prefix_keys_with_bs }
    end

    def component_class
      class_names = %w[carousel slide]
      class_names << %w[carousel-fade] if crossfade?
      class_names << %w[carousel-dark] if dark?
      class_names.join(' ')
    end

    %i[controls indicators crossfade dark].each do |name|
      define_method("#{name}?") do
        !instance_variable_get("@#{name}").nil?
      end
    end
  end
end

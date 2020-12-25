# frozen_string_literal: true

module Bs5
  class ModalComponent < ViewComponent::Base
    include ViewComponent::SlotableV2
    using HashRefinement

    MODAL_OPTIONS = %i[backdrop keyboard focus].freeze

    renders_one :controller, lambda { |_modal_id: nil|
      Bs5::Modal::ControllerComponent.new(modal_id: modal_id)
    }
    renders_one :header, lambda { |_label_id: nil|
      Bs5::Modal::HeaderComponent.new(label_id: label_id)
    }
    renders_one :body, Bs5::Modal::BodyComponent
    renders_one :footer, Bs5::Modal::FooterComponent

    def initialize(options = {})
      @options = options.symbolize_keys
      extract_options
    end

    private

    def extract_options
      # @split = @options.delete(:split)
      # @dark = @options.delete(:dark)
      # @direction = @options.delete(:direction)
      # @align = @options.delete(:align)

      extract_modal_options
    end

    def extract_modal_options
      @modal_options = @options.extract!(*MODAL_OPTIONS)
    end

    def modal_attributes
      { class: 'modal fade',
        id: modal_id,
        tabindex: -1,
        aria: { labelledby: label_id, hidden: true },
        data: @modal_options.prefix_keys_with_bs }
    end

    def modal_id
      "modal-#{object_id}"
    end

    def label_id
      "modal-label-#{object_id}"
    end
  end
end

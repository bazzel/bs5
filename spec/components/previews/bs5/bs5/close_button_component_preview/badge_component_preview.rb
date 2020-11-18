# frozen_string_literal: true

module Bs5
  class CloseButtonComponentPreview < ViewComponent::Preview
    def default
      render_with_template(template: 'bs5/bs5/close_button_component_preview/default')
    end

    def disabled
      render_with_template(template: 'bs5/bs5/close_button_component_preview/disabled')
    end

    def white
      render_with_template(template: 'bs5/bs5/close_button_component_preview/white')
    end
  end
end

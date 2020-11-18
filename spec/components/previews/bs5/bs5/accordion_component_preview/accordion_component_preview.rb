# frozen_string_literal: true

module Bs5
  class AccordionComponentPreview < ViewComponent::Preview
    def default
      render_with_template(template: 'bs5/bs5/accordion_component_preview/default')
    end

    def flush
      render_with_template(template: 'bs5/bs5/accordion_component_preview/flush')
    end
  end
end

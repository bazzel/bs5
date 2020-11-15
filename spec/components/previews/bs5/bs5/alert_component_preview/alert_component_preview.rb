# frozen_string_literal: true

module Bs5
  class AlertComponentPreview < ViewComponent::Preview
    def default
      render_with_template(template: 'bs5/bs5/alert_component_preview/default')
    end

    def with_danger_type
      render_with_template(template: 'bs5/bs5/alert_component_preview/with_danger_type')
    end

    def dismissing
      render_with_template(template: 'bs5/bs5/alert_component_preview/dismissing')
    end
  end
end

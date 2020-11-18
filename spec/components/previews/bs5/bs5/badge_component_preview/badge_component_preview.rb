# frozen_string_literal: true

module Bs5
  class BadgeComponentPreview < ViewComponent::Preview
    def default
      render_with_template(template: 'bs5/bs5/badge_component_preview/default')
    end

    def with_danger_type
      render_with_template(template: 'bs5/bs5/badge_component_preview/with_danger_type')
    end

    def pill
      render_with_template(template: 'bs5/bs5/badge_component_preview/pill')
    end
  end
end

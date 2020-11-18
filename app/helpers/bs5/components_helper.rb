# frozen_string_literal: true

module Bs5
  module ComponentsHelper
    def bs5_accordion(*args)
      render AccordionComponent.new(*args) do |accordion|
        yield accordion if block_given?
      end
    end

    def bs5_alert(*args)
      render AlertComponent.new(*args) do
        yield if block_given?
      end
    end

    def bs5_badge(*args)
      render BadgeComponent.new(*args)
    end
  end
end

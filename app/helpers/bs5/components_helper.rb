# frozen_string_literal: true

module Bs5
  module ComponentsHelper
    def bs5_alert(*args)
      render AlertComponent.new(*args) do
        yield if block_given?
      end
    end
  end
end

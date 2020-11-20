# frozen_string_literal: true

module Bs5
  module ExamplesHelper
    def bs5_example(*args)
      render ExampleComponent.new(*args)
    end
  end
end

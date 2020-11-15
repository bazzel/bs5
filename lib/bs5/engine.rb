# frozen_string_literal: true

require 'view_component/engine'
module Bs5
  class Engine < ::Rails::Engine
    isolate_namespace Bs5

    # Previewing ViewComponents
    config.before_configuration do |app|
      app.config.view_component.preview_paths << "#{Bs5::Engine.root}/spec/components/previews"
    end
  end
end

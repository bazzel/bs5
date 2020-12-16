# frozen_string_literal: true

require 'view_component/engine'
require 'sprockets/railtie'
module Bs5
  class Engine < ::Rails::Engine
    isolate_namespace Bs5

    # Previewing ViewComponents
    config.before_configuration do |app|
      app.config.view_component.preview_paths << "#{Bs5::Engine.root}/spec/components/previews"
    end

    initializer 'bs5.assets.precompile' do |app|
      app.config.assets.paths << Rails.root.join('app/assets/javascripts')
      app.config.assets.precompile << 'bs5/application.js'
    end
  end
end

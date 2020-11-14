# frozen_string_literal: true

require 'view_component/engine'
module Bs5
  class Engine < ::Rails::Engine
    isolate_namespace Bs5
  end
end

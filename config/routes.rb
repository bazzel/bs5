# frozen_string_literal: true

Bs5::Engine.routes.draw do
  get 'examples/index'

  root to: 'examples#index'
end

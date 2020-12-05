# frozen_string_literal: true

Bs5::Engine.routes.draw do
  get 'pages/:page', to: 'pages#show', as: :pages

  root to: 'pages#show', page: 'accordion'
end

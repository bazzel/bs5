# frozen_string_literal: true

Rails.application.routes.draw do
  mount Bs5::Engine => '/bs5'
end

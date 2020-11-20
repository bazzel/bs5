# frozen_string_literal: true

module Bs5
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :set_views_path

    private

    def set_views_path
      append_view_path Engine.root.join('app', 'views', 'bs5', 'examples')
    end
  end
end

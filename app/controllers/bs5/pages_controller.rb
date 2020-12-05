# frozen_string_literal: true

require_dependency 'bs5/application_controller'

module Bs5
  class PagesController < ApplicationController
    def show
      render template: "bs5/pages/#{params[:page]}"
    end
  end
end

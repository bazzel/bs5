# frozen_string_literal: true

module Bs5
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end

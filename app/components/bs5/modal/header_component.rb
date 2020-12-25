# frozen_string_literal: true

module Bs5
  module Modal
    class HeaderComponent < ViewComponent::Base
      attr_reader :title

      def initialize(title: nil, label_id: nil)
        @title = title
        @label_id = label_id
      end

      def content
        title || @content
      end
    end
  end
end

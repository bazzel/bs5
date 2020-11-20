# frozen_string_literal: true

require 'rouge'
module Bs5
  module RougeHelper
    def rouge(text)
      formatter = Rouge::Formatters::HTML.new(css_class: 'highlight')
      lexer = Rouge::Lexers::ERB.new
      tag.div(class: 'highlight') do
        content_tag(:pre) do
          content_tag(:code) do
            raw formatter.format(lexer.lex(text))
          end
        end
      end
    end
  end
end

# frozen_string_literal: true

require 'rouge'

module Bs5
  class ExampleComponent < ViewComponent::Base
    include ComponentsHelper

    attr_reader :snippet

    def initialize(snippet:)
      @snippet = snippet
      @path = snippet.split('/')
      @basename = @path.pop
    end

    def highlight
      formatter = Rouge::Formatters::HTML.new
      lexer = Rouge::Lexer.find(language)
      formatter.format(lexer.lex(file_content)).html_safe # rubocop:disable Rails/OutputSafety
    end

    private

    def file_content
      @file_content ||= file.read
    end

    def file
      @file ||= examples_path
                .join(*@path)
                .children
                .find { |ch| ch.basename.to_s.start_with?(@basename) }
    end

    def examples_path
      Engine.root.join('app', 'views', 'bs5', 'examples')
    end

    def language
      file.extname.delete('.')
    end
  end
end

# frozen_string_literal: true

return unless defined?(RuboCop)

require 'rubocop/rake_task'

RuboCop::RakeTask.new(:rubocop)

# frozen_string_literal: true

return unless RuboCop

require 'rubocop/rake_task'

RuboCop::RakeTask.new(:rubocop)

require 'test_helper'
require 'generators/bs5/install/install_generator'

module Bs5
  class Bs5::InstallGeneratorTest < Rails::Generators::TestCase
    tests Bs5::InstallGenerator
    destination Rails.root.join('tmp/generators')
    setup :prepare_destination

    # test "generator runs without errors" do
    #   assert_nothing_raised do
    #     run_generator ["arguments"]
    #   end
    # end
  end
end

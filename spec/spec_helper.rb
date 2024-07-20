# frozen_string_literal: true

require "bundler/setup"

require "support/file_fixture_helper"

require "simplecov" if %w[yes y true 1].include? ENV["COVERAGE"]&.downcase

RSpec.configure do |config|
  include FileFixtureHelper

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

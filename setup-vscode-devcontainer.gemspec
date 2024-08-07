# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "setup_vscode_devcontainer/version"

Gem::Specification.new do |spec|
  spec.name          = "setup-vscode-devcontainer"
  spec.version       = SetupVSCodeDevcontainer::VERSION
  spec.authors       = ["John Carney"]
  spec.email         = ["john@carney.id.au"]

  spec.summary       = "Sets up a Visual Studio Code dev container for a rails app."
  spec.description   = "Sets up a Visual Studio Code dev container for a rails app."
  spec.homepage      = "https://github.com/johncarney/setup-vscode-devcontainer"
  spec.license       = "MIT"

  spec.required_ruby_version = ">= 2.6.10"

  unless spec.respond_to?(:metadata)
    raise <<~MESSAGE
      RubyGems 2.0 or newer is required to protect against public gem pushes.
    MESSAGE
  end

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.metadata["homepage_uri"]    = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   = %w[setup-vscode-devcontainer]
  spec.require_paths = %w[lib]

  spec.add_development_dependency "bundler",       "~> 1.17"
  spec.add_development_dependency "irb",           "~> 1.6.3"
  spec.add_development_dependency "rake",          "~> 12.3"
  spec.add_development_dependency "rspec",         "~> 3.13"
  spec.add_development_dependency "rubocop-rake",  "~> 0.6"
  spec.add_development_dependency "rubocop-rspec", "~> 2.20"
  spec.add_development_dependency "simplecov",     "~> 0.22"
end

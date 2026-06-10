# frozen_string_literal: true

require_relative "lib/vindi/version"

Gem::Specification.new do |spec|
  spec.name = "vindi-rails"
  spec.version = Vindi::VERSION
  spec.authors = ["Wesley Lima"]
  spec.email = ["wesleyskap@gmail.com"]

  spec.summary = "Ruby/Rails integration SDK for the Vindi API v1 (recurring billing platform)."
  spec.description = "Allows interaction with the Vindi API in an elegant and integrated way with Ruby/Rails."
  spec.homepage = "https://github.com/wesleyskap/vindi-rails"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  rescue StandardError
    Dir["lib/**/*"]
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rest-client", "~> 2.1"
end

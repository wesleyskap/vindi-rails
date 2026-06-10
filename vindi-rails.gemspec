# frozen_string_literal: true

require_relative "lib/vindi/version"

Gem::Specification.new do |spec|
  spec.name = "vindi-rails"
  spec.version = Vindi::VERSION
  spec.authors = ["Your Name"]
  spec.email = ["your-email@example.com"]

  spec.summary = "SDK Ruby/Rails para integração com a plataforma de cobranças recorrentes Vindi"
  spec.description = "Permite interagir com a API da Vindi de forma elegante e integrada com Ruby/Rails."
  spec.homepage = "https://github.com/your-username/vindi-rails"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://rubygems.org'"

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

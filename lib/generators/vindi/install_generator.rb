# frozen_string_literal: true

require "rails/generators"

module Vindi
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      desc "Creates a Vindi initializer to configure your API credentials."

      def copy_initializer
        template "vindi.rb", "config/initializers/vindi.rb"
      end
    end
  end
end

# frozen_string_literal: true

module Vindi
  class Role < Resource
    extend APIOperations::List

    def self.endpoint
      "roles"
    end
  end
end

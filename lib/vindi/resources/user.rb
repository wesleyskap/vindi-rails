# frozen_string_literal: true

module Vindi
  class User < Resource
    extend APIOperations::List

    def self.endpoint
      "users"
    end
  end
end

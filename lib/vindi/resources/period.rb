# frozen_string_literal: true

module Vindi
  class Period < Resource
    extend APIOperations::List

    def self.endpoint
      "periods"
    end
  end
end

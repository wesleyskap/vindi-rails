# frozen_string_literal: true

module Vindi
  class Affiliate < Resource
    extend APIOperations::List

    def self.endpoint
      "affiliates"
    end
  end
end

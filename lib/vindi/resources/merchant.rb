# frozen_string_literal: true

module Vindi
  class Merchant < Resource
    extend APIOperations::List

    def self.endpoint
      "merchants"
    end
  end
end

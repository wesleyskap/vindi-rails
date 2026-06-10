# frozen_string_literal: true

module Vindi
  class Discount < Resource
    extend APIOperations::List
    extend APIOperations::Create
    extend APIOperations::Delete

    def self.endpoint
      "discounts"
    end
  end
end

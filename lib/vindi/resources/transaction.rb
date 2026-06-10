# frozen_string_literal: true

module Vindi
  class Transaction < Resource
    extend APIOperations::List
    extend APIOperations::Create

    def self.endpoint
      "transactions"
    end
  end
end

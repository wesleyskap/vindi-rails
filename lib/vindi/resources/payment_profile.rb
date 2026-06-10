# frozen_string_literal: true

module Vindi
  class PaymentProfile < Resource
    extend APIOperations::List
    extend APIOperations::Create
    extend APIOperations::Delete

    def self.endpoint
      "payment_profiles"
    end
  end
end

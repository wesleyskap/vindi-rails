# frozen_string_literal: true

module Vindi
  class PaymentMethod < Resource
    extend APIOperations::List

    def self.endpoint
      "payment_methods"
    end
  end
end

# frozen_string_literal: true

module Vindi
  class MerchantUser < Resource
    extend APIOperations::List

    def self.endpoint
      "merchant_users"
    end
  end
end

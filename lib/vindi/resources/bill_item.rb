# frozen_string_literal: true

module Vindi
  class BillItem < Resource
    extend APIOperations::List

    def self.endpoint
      "bill_items"
    end
  end
end

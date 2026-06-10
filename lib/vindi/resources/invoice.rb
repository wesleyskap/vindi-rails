# frozen_string_literal: true

module Vindi
  class Invoice < Resource
    extend APIOperations::List

    def self.endpoint
      "invoices"
    end
  end
end

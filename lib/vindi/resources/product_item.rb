# frozen_string_literal: true

module Vindi
  class ProductItem < Resource
    extend APIOperations::List
    extend APIOperations::Create
    extend APIOperations::Update
    extend APIOperations::Delete

    def self.endpoint
      "product_items"
    end
  end
end

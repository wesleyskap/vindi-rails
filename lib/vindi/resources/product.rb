# frozen_string_literal: true

module Vindi
  class Product < Resource
    extend APIOperations::List
    extend APIOperations::Create
    extend APIOperations::Update
    extend APIOperations::Delete

    def self.endpoint
      "products"
    end
  end
end

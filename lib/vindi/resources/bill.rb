# frozen_string_literal: true

module Vindi
  class Bill < Resource
    extend APIOperations::List
    extend APIOperations::Create
    extend APIOperations::Update
    extend APIOperations::Delete

    def self.endpoint
      "bills"
    end
  end
end

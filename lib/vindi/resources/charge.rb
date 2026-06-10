# frozen_string_literal: true

module Vindi
  class Charge < Resource
    extend APIOperations::List
    extend APIOperations::Create
    extend APIOperations::Update

    def self.endpoint
      "charges"
    end
  end
end

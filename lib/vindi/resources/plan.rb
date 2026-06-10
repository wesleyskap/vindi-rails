# frozen_string_literal: true

module Vindi
  class Plan < Resource
    extend APIOperations::List
    extend APIOperations::Create
    extend APIOperations::Update
    extend APIOperations::Delete

    def self.endpoint
      "plans"
    end
  end
end

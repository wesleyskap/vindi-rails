# frozen_string_literal: true

module Vindi
  class Subscription < Resource
    extend APIOperations::List
    extend APIOperations::Create
    extend APIOperations::Update
    extend APIOperations::Delete

    def self.endpoint
      "subscriptions"
    end
  end
end

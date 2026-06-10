# frozen_string_literal: true

module Vindi
  class Usage < Resource
    extend APIOperations::List
    extend APIOperations::Create
    extend APIOperations::Delete

    def self.endpoint
      "usages"
    end
  end
end

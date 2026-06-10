# frozen_string_literal: true

module Vindi
  class Issue < Resource
    extend APIOperations::List
    extend APIOperations::Update

    def self.endpoint
      "issues"
    end
  end
end

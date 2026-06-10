# frozen_string_literal: true

module Vindi
  class Movement < Resource
    extend APIOperations::List

    def self.endpoint
      "movements"
    end
  end
end

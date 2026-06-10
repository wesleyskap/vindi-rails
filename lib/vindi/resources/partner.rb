# frozen_string_literal: true

module Vindi
  class Partner < Resource
    extend APIOperations::List

    def self.endpoint
      "partner"
    end
  end
end

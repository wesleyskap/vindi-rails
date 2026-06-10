# frozen_string_literal: true

module Vindi
  class Message < Resource
    extend APIOperations::List

    def self.endpoint
      "messages"
    end
  end
end

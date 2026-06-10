# frozen_string_literal: true

module Vindi
  class Notification < Resource
    extend APIOperations::List

    def self.endpoint
      "notifications"
    end
  end
end

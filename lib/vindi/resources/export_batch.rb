# frozen_string_literal: true

module Vindi
  class ExportBatch < Resource
    extend APIOperations::List
    extend APIOperations::Create

    def self.endpoint
      "export_batches"
    end
  end
end

# frozen_string_literal: true

module Vindi
  class ImportBatch < Resource
    extend APIOperations::List
    extend APIOperations::Create

    def self.endpoint
      "import_batches"
    end
  end
end

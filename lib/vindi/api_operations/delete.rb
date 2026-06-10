# frozen_string_literal: true

module Vindi
  module APIOperations
    module Delete
      def delete(id)
        response = Client.request(:delete, "#{endpoint}/#{id}")
        singular_key = endpoint.end_with?("batches") ? endpoint.sub(/es$/, "").to_sym : endpoint.chomp("s").to_sym
        resource_attrs = response.key?(singular_key) ? response[singular_key] : response
        new(resource_attrs)
      end
      alias destroy delete
    end
  end
end

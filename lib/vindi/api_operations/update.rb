# frozen_string_literal: true

module Vindi
  module APIOperations
    module Update
      def update(id, params = {})
        response = Client.request(:put, "#{endpoint}/#{id}", params)
        singular_key = endpoint.chomp("s").to_sym
        resource_attrs = response.key?(singular_key) ? response[singular_key] : response
        new(resource_attrs)
      end
    end
  end
end

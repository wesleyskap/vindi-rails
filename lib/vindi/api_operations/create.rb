# frozen_string_literal: true

module Vindi
  module APIOperations
    module Create
      def create(params = {})
        response = Client.request(:post, endpoint, params)
        singular_key = endpoint.chomp("s").to_sym
        resource_attrs = response.key?(singular_key) ? response[singular_key] : response
        new(resource_attrs)
      end
    end
  end
end

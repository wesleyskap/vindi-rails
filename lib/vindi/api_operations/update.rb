# frozen_string_literal: true

module Vindi
  module APIOperations
    module Update
      def update(id, params = {}, opts = {})
        headers = {}
        headers["Idempotency-Key"] = opts[:idempotency_key] if opts[:idempotency_key]
        headers.merge!(opts[:headers]) if opts[:headers]

        response = Client.request(:put, "#{endpoint}/#{id}", params, headers)
        singular_key = endpoint.end_with?("batches") ? endpoint.sub(/es$/, "").to_sym : endpoint.chomp("s").to_sym
        resource_attrs = response.key?(singular_key) ? response[singular_key] : response
        new(resource_attrs)
      end
    end
  end
end

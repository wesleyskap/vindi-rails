# frozen_string_literal: true

module Vindi
  module APIOperations
    module List
      def list(params = {})
        response = Client.request(:get, endpoint, params)
        key = endpoint.to_sym
        items = response[key] || response[:results] || []
        items.map { |item_attrs| new(item_attrs) }
      end
    end
  end
end

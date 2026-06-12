# frozen_string_literal: true

module Vindi
  class Resource
    attr_reader :attributes

    def initialize(attributes = {})
      @attributes = attributes || {}
    end

    def inspect
      "#<#{self.class} #{attributes.inspect}>"
    end

    def method_missing(method_name, *args, &block)
      if attributes.key?(method_name)
        attributes[method_name]
      else
        super
      end
    end

    def respond_to_missing?(method_name, include_private = false)
      attributes.key?(method_name) || super
    end

    def self.endpoint
      raise NotImplementedError, "Subclasses must implement .endpoint"
    end

    def self.find(id)
      response = Client.request(:get, "#{endpoint}/#{id}")
      new(response)
    end
  end
end

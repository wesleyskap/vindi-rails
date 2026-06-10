# frozen_string_literal: true

module Vindi
  class Configuration
    attr_accessor :api_key, :api_url

    DEFAULT_API_URL = "https://sandbox-gp.vindi.com.br/api/v1"

    def initialize
      @api_key = nil
      @api_url = DEFAULT_API_URL
    end
  end
end

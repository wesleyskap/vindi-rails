# frozen_string_literal: true

module Vindi
  class Configuration
    attr_accessor :api_key, :api_url, :cache_store, :cache_ttl, :cached_resources,
                  :max_retries, :retry_backoff_factor, :retry_base_delay

    DEFAULT_API_URL = "https://sandbox-gp.vindi.com.br/api/v1"

    def initialize
      @api_key = nil
      @api_url = DEFAULT_API_URL
      @cache_store = nil
      @cache_ttl = 300
      @cached_resources = %i[plans products discounts payment_methods]
      @max_retries = 3
      @retry_backoff_factor = 2
      @retry_base_delay = 1.0
    end
  end
end

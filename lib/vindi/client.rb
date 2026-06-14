# frozen_string_literal: true

require "base64"
require "digest"

module Vindi
  class Client
    class << self
      def request(method, path, params = {}, headers = {})
        api_key = Vindi.configuration.api_key
        raise UnauthorizedError.new("API key is not configured.", status: 401) unless api_key

        url = build_url(path)
        payload = build_payload(method, params)
        req_headers = build_headers(api_key, headers)

        if cacheable?(method, path)
          fetch_from_cache(path, params) { execute_request(method, url, payload, req_headers) }
        else
          execute_request(method, url, payload, req_headers)
        end
      rescue RestClient::Exception => e
        handle_rest_client_error(e)
      end

      private

      def cacheable?(method, path)
        return false unless method.to_sym.downcase == :get
        return false unless Vindi.configuration.cache_store

        resource = path.split("/").first&.to_sym
        Vindi.configuration.cached_resources&.include?(resource)
      end

      def fetch_from_cache(path, params, &block)
        key = cache_key(path, params)
        Vindi.configuration.cache_store.fetch(key, expires_in: Vindi.configuration.cache_ttl, &block)
      end

      def cache_key(path, params)
        hash = Digest::MD5.hexdigest(params.to_json)
        "vindi:cache:#{path}:#{hash}"
      end

      def build_url(path)
        "#{Vindi.configuration.api_url}/#{path.sub(%r{^/}, '')}"
      end

      def build_payload(method, params)
        return nil if %i[get delete].include?(method.to_sym.downcase)
        params.to_json
      end

      def build_headers(api_key, custom_headers)
        auth = Base64.strict_encode64("#{api_key}:")
        {
          "Authorization" => "Basic #{auth}",
          "Content-Type" => "application/json",
          "Accept" => "application/json"
        }.merge(custom_headers)
      end

      def execute_request(method, url, payload, headers)
        options = { method: method.to_sym, url: url, headers: headers }
        options[:payload] = payload if payload
        response = RestClient::Request.execute(options)
        JSON.parse(response.body, symbolize_names: true)
      end

      def handle_rest_client_error(error)
        status = error.response&.code
        body = error.response&.body
        message = "HTTP request failed: #{error.message}. Response: #{body}"

        raise_specific_error(message, status, body)
      end

      def raise_specific_error(msg, status, body)
        case status
        when 401 then raise UnauthorizedError.new(msg, status: status, response_body: body)
        when 403 then raise ForbiddenError.new(msg, status: status, response_body: body)
        when 404 then raise NotFoundError.new(msg, status: status, response_body: body)
        when 422 then raise UnprocessableEntityError.new(msg, status: status, response_body: body)
        when 429 then raise RateLimitError.new(msg, status: status, response_body: body)
        when 500..599 then raise InternalServerError.new(msg, status: status, response_body: body)
        else raise APIError.new(msg, status: status, response_body: body)
        end
      end
    end
  end
end

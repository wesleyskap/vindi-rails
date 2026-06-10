# frozen_string_literal: true

module Vindi
  class Error < StandardError; end

  class APIError < Error
    attr_reader :status, :response_body

    def initialize(message, status: nil, response_body: nil)
      super(message)
      @status = status
      @response_body = response_body
    end
  end

  class UnauthorizedError < APIError; end
  class ForbiddenError < APIError; end
  class NotFoundError < APIError; end
  class UnprocessableEntityError < APIError; end
  class RateLimitError < APIError; end
  class InternalServerError < APIError; end
end

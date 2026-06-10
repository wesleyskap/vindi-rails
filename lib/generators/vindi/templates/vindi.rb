# frozen_string_literal: true

Vindi.configure do |config|
  # Set your Vindi private API key.
  # We recommend using Rails credentials or environment variables.
  config.api_key = ENV["VINDI_API_KEY"]

  # Set the base URL for the API (default is sandbox).
  # For production, use: "https://gp.vindi.com.br/api/v1"
  # config.api_url = "https://sandbox-gp.vindi.com.br/api/v1"
end

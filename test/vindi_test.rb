# frozen_string_literal: true

require "test_helper"

class VindiTest < Minitest::Test
  def setup
    Vindi.configuration = nil
  end

  def test_configure_sets_api_key_and_api_url
    Vindi.configure do |config|
      config.api_key = "test_key"
      config.api_url = "https://example.com/api"
    end

    assert_equal "test_key", Vindi.configuration.api_key
    assert_equal "https://example.com/api", Vindi.configuration.api_url
  end

  def test_successful_get_returns_parsed_json
    setup_test_config

    stub_request(:get, "https://sandbox-gp.vindi.com.br/api/v1/customers")
      .with(headers: { "Authorization" => "Basic YWJjMTIzNDU6" })
      .to_return(status: 200, body: '{"customers":[{"id":123,"name":"Test"}]}')

    res = Vindi::Customer.list
    assert_kind_of Array, res
    assert_kind_of Vindi::Customer, res.first
    assert_equal "Test", res.first.name
    assert_equal 123, res.first.id
  end

  def test_raises_unauthorized_error_on_401_response
    setup_test_config

    stub_request(:post, "https://sandbox-gp.vindi.com.br/api/v1/customers")
      .to_return(status: 401, body: "Unauthorized")

    assert_raises Vindi::UnauthorizedError do
      Vindi::Customer.create(name: "Test")
    end
  end

  def test_successful_put_updates_resource_attributes
    setup_test_config

    stub_request(:put, "https://sandbox-gp.vindi.com.br/api/v1/customers/123")
      .to_return(status: 200, body: '{"customer":{"id":123,"name":"New Name"}}')

    customer = Vindi::Customer.update(123, name: "New Name")
    assert_equal "New Name", customer.name
    assert_equal 123, customer.id
  end

  def test_successful_delete
    setup_test_config

    stub_request(:delete, "https://sandbox-gp.vindi.com.br/api/v1/customers/123")
      .to_return(status: 200, body: '{"customer":{"id":123,"status":"archived"}}')

    customer = Vindi::Customer.delete(123)
    assert_equal "archived", customer.status
  end

  private

  def setup_test_config
    Vindi.configure do |config|
      config.api_key = "abc12345"
      config.api_url = "https://sandbox-gp.vindi.com.br/api/v1"
    end
  end
end

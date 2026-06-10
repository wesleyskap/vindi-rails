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

  def test_plan_crud_operations
    setup_test_config

    stub_request(:post, "https://sandbox-gp.vindi.com.br/api/v1/plans")
      .to_return(status: 200, body: '{"plan":{"id":999,"name":"Gold Plan"}}')

    plan = Vindi::Plan.create(name: "Gold Plan")
    assert_equal "Gold Plan", plan.name
    assert_equal 999, plan.id
  end

  def test_product_crud_operations
    setup_test_config

    stub_request(:post, "https://sandbox-gp.vindi.com.br/api/v1/products")
      .to_return(status: 200, body: '{"product":{"id":888,"name":"Course"}}')

    product = Vindi::Product.create(name: "Course")
    assert_equal "Course", product.name
    assert_equal 888, product.id
  end

  def test_product_item_crud_operations
    setup_test_config

    stub_request(:post, "https://sandbox-gp.vindi.com.br/api/v1/product_items")
      .to_return(status: 200, body: '{"product_item":{"id":777,"product_id":888}}')

    item = Vindi::ProductItem.create(product_id: 888)
    assert_equal 777, item.id
    assert_equal 888, item.product_id
  end

  def test_discount_crud_operations
    setup_test_config

    stub_request(:post, "https://sandbox-gp.vindi.com.br/api/v1/discounts")
      .to_return(status: 200, body: '{"discount":{"id":666,"amount":10.5}}')

    discount = Vindi::Discount.create(amount: 10.5)
    assert_equal 666, discount.id
    assert_equal 10.5, discount.amount
  end

  private

  def setup_test_config
    Vindi.configure do |config|
      config.api_key = "abc12345"
      config.api_url = "https://sandbox-gp.vindi.com.br/api/v1"
    end
  end
end

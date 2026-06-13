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

  def test_bill_crud_operations
    setup_test_config

    stub_request(:post, "https://sandbox-gp.vindi.com.br/api/v1/bills")
      .to_return(status: 200, body: '{"bill":{"id":555,"amount":100.0}}')

    bill = Vindi::Bill.create(amount: 100.0)
    assert_equal 555, bill.id
    assert_equal 100.0, bill.amount
  end

  def test_bill_item_operations
    setup_test_config

    stub_request(:get, "https://sandbox-gp.vindi.com.br/api/v1/bill_items")
      .to_return(status: 200, body: '{"bill_items":[{"id":444,"amount":50.0}]}')

    items = Vindi::BillItem.list
    assert_kind_of Array, items
    assert_equal 444, items.first.id
    assert_equal 50.0, items.first.amount
  end

  def test_period_operations
    setup_test_config

    stub_request(:get, "https://sandbox-gp.vindi.com.br/api/v1/periods")
      .to_return(status: 200, body: '{"periods":[{"id":333,"start_at":"2026-06-10"}]}')

    periods = Vindi::Period.list
    assert_kind_of Array, periods
    assert_equal 333, periods.first.id
    assert_equal "2026-06-10", periods.first.start_at
  end

  def test_transaction_operations
    setup_test_config

    stub_request(:post, "https://sandbox-gp.vindi.com.br/api/v1/transactions")
      .to_return(status: 200, body: '{"transaction":{"id":222,"amount":100.0}}')

    tx = Vindi::Transaction.create(amount: 100.0)
    assert_equal 222, tx.id
    assert_equal 100.0, tx.amount
  end

  def test_usage_operations
    setup_test_config

    stub_request(:post, "https://sandbox-gp.vindi.com.br/api/v1/usages")
      .to_return(status: 200, body: '{"usage":{"id":111,"quantity":5}}')

    usage = Vindi::Usage.create(quantity: 5)
    assert_equal 111, usage.id
    assert_equal 5, usage.quantity
  end

  def test_invoice_operations
    setup_test_config
    stub_request(:get, "https://sandbox-gp.vindi.com.br/api/v1/invoices")
      .to_return(status: 200, body: '{"invoices":[{"id":1001,"status":"issued"}]}')

    res = Vindi::Invoice.list
    assert_equal 1001, res.first.id
  end

  def test_movement_operations
    setup_test_config
    stub_request(:get, "https://sandbox-gp.vindi.com.br/api/v1/movements")
      .to_return(status: 200, body: '{"movements":[{"id":1002,"amount":150.0}]}')

    res = Vindi::Movement.list
    assert_equal 1002, res.first.id
  end

  def test_message_operations
    setup_test_config
    stub_request(:get, "https://sandbox-gp.vindi.com.br/api/v1/messages")
      .to_return(status: 200, body: '{"messages":[{"id":1003,"subject":"Welcome"}]}')

    res = Vindi::Message.list
    assert_equal 1003, res.first.id
  end

  def test_batch_operations
    setup_test_config
    stub_request(:post, "https://sandbox-gp.vindi.com.br/api/v1/export_batches")
      .to_return(status: 200, body: '{"export_batch":{"id":1004}}')
    stub_request(:post, "https://sandbox-gp.vindi.com.br/api/v1/import_batches")
      .to_return(status: 200, body: '{"import_batch":{"id":1005}}')

    eb = Vindi::ExportBatch.create
    ib = Vindi::ImportBatch.create
    assert_equal 1004, eb.id
    assert_equal 1005, ib.id
  end

  def test_issue_operations
    setup_test_config
    stub_request(:put, "https://sandbox-gp.vindi.com.br/api/v1/issues/1006")
      .to_return(status: 200, body: '{"issue":{"id":1006,"status":"resolved"}}')

    issue = Vindi::Issue.update(1006, status: "resolved")
    assert_equal "resolved", issue.status
  end

  def test_notification_operations
    setup_test_config
    stub_request(:get, "https://sandbox-gp.vindi.com.br/api/v1/notifications")
      .to_return(status: 200, body: '{"notifications":[{"id":1007}]}')

    res = Vindi::Notification.list
    assert_equal 1007, res.first.id
  end

  def test_merchant_operations
    setup_test_config
    stub_request(:get, "https://sandbox-gp.vindi.com.br/api/v1/merchants")
      .to_return(status: 200, body: '{"merchants":[{"id":1008}]}')
    stub_request(:get, "https://sandbox-gp.vindi.com.br/api/v1/merchant_users")
      .to_return(status: 200, body: '{"merchant_users":[{"id":1009}]}')

    m = Vindi::Merchant.list
    mu = Vindi::MerchantUser.list
    assert_equal 1008, m.first.id
    assert_equal 1009, mu.first.id
  end

  def test_user_and_role_operations
    setup_test_config
    stub_request(:get, "https://sandbox-gp.vindi.com.br/api/v1/roles")
      .to_return(status: 200, body: '{"roles":[{"id":1010,"name":"admin"}]}')
    stub_request(:get, "https://sandbox-gp.vindi.com.br/api/v1/users")
      .to_return(status: 200, body: '{"users":[{"id":1011,"email":"user@test.com"}]}')

    roles = Vindi::Role.list
    users = Vindi::User.list
    assert_equal 1010, roles.first.id
    assert_equal 1011, users.first.id
  end

  def test_public_and_partner_and_affiliate_operations
    setup_test_config
    stub_request(:get, "https://sandbox-gp.vindi.com.br/api/v1/affiliates")
      .to_return(status: 200, body: '{"affiliates":[{"id":1012}]}')
    stub_request(:get, "https://sandbox-gp.vindi.com.br/api/v1/partner")
      .to_return(status: 200, body: '{"partner":[{"id":1013}]}')

    pub = Vindi::Public.new(id: 1014)
    aff = Vindi::Affiliate.list
    part = Vindi::Partner.list

    assert_equal 1014, pub.id
    assert_equal 1012, aff.first.id
    assert_equal 1013, part.first.id
  end

  def test_generator_loading
    begin
      require "rails/generators"
    rescue LoadError
      skip "Rails generators not available"
    end

    require_relative "../lib/generators/vindi/install_generator"
    assert defined?(Vindi::Generators::InstallGenerator)
  end

  def test_create_supports_idempotency_key
    setup_test_config

    stub_request(:post, "https://sandbox-gp.vindi.com.br/api/v1/customers")
      .with(headers: { "Idempotency-Key" => "unique-key-123" })
      .to_return(status: 200, body: '{"customer":{"id":123,"name":"Test"}}')

    customer = Vindi::Customer.create({ name: "Test" }, idempotency_key: "unique-key-123")
    assert_equal 123, customer.id
  end

  def test_update_supports_idempotency_key
    setup_test_config

    stub_request(:put, "https://sandbox-gp.vindi.com.br/api/v1/customers/123")
      .with(headers: { "Idempotency-Key" => "unique-key-456" })
      .to_return(status: 200, body: '{"customer":{"id":123,"name":"New Name"}}')

    customer = Vindi::Customer.update(123, { name: "New Name" }, idempotency_key: "unique-key-456")
    assert_equal "New Name", customer.name
  end

  private

  def setup_test_config
    Vindi.configure do |config|
      config.api_key = "abc12345"
      config.api_url = "https://sandbox-gp.vindi.com.br/api/v1"
    end
  end
end

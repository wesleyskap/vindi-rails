# frozen_string_literal: true

require "rest-client"
require "json"

require_relative "vindi/version"
require_relative "vindi/configuration"
require_relative "vindi/errors"
require_relative "vindi/client"
require_relative "vindi/api_operations/create"
require_relative "vindi/api_operations/delete"
require_relative "vindi/api_operations/list"
require_relative "vindi/api_operations/update"
require_relative "vindi/resource"

# Load all resources
require_relative "vindi/resources/customer"
require_relative "vindi/resources/payment_profile"
require_relative "vindi/resources/subscription"
require_relative "vindi/resources/charge"
require_relative "vindi/resources/plan"
require_relative "vindi/resources/product"
require_relative "vindi/resources/payment_method"
require_relative "vindi/resources/discount"
require_relative "vindi/resources/product_item"
require_relative "vindi/resources/period"
require_relative "vindi/resources/bill"
require_relative "vindi/resources/bill_item"
require_relative "vindi/resources/transaction"
require_relative "vindi/resources/usage"
require_relative "vindi/resources/invoice"
require_relative "vindi/resources/movement"
require_relative "vindi/resources/message"
require_relative "vindi/resources/export_batch"
require_relative "vindi/resources/import_batch"
require_relative "vindi/resources/issue"
require_relative "vindi/resources/notification"
require_relative "vindi/resources/merchant"
require_relative "vindi/resources/merchant_user"
require_relative "vindi/resources/role"
require_relative "vindi/resources/user"
require_relative "vindi/resources/public"
require_relative "vindi/resources/affiliate"
require_relative "vindi/resources/partner"

module Vindi
  class << self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end

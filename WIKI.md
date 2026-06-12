# Vindi SDK Wiki

[Leia em Português (WIKI.pt-BR.md)](./WIKI.pt-BR.md)

Welcome to the `vindi-rails` SDK Wiki. This document details all the mapped resources, operations, and advanced usage guidelines.

---

## 1. SDK Design & Architecture

The SDK uses `RestClient` internally to communicate with the Vindi API.
Resources are represented as Ruby objects inheriting from `Vindi::Resource`. Attributes returned from the API are accessible via dot-notation methods on the instances.

### Error Handling

The SDK raises specific error classes based on HTTP status codes. All errors inherit from `Vindi::Error`:

- `Vindi::UnauthorizedError` (401)
- `Vindi::ForbiddenError` (403)
- `Vindi::NotFoundError` (404)
- `Vindi::UnprocessableEntityError` (422)
- `Vindi::RateLimitError` (429)
- `Vindi::InternalServerError` (500+)
- `Vindi::APIError` (Fallback for other HTTP statuses)

---

## 2. Resource Mapping & CRUD Capabilities

The table below lists all mapped resources and their operations:

| Resource Class | Endpoint | CRUD Operations Enabled |
| :--- | :--- | :--- |
| `Vindi::Customer` | `customers` | `list`, `create`, `update`, `delete` |
| `Vindi::PaymentProfile` | `payment_profiles` | `list`, `create`, `delete` |
| `Vindi::Subscription` | `subscriptions` | `list`, `create`, `update`, `delete` |
| `Vindi::Charge` | `charges` | `list`, `create`, `update` |
| `Vindi::Plan` | `plans` | `list`, `create`, `update`, `delete` |
| `Vindi::Product` | `products` | `list`, `create`, `update`, `delete` |
| `Vindi::ProductItem` | `product_items` | `list`, `create`, `update`, `delete` |
| `Vindi::Discount` | `discounts` | `list`, `create`, `delete` |
| `Vindi::Bill` | `bills` | `list`, `create`, `update`, `delete` |
| `Vindi::BillItem` | `bill_items` | `list` |
| `Vindi::Period` | `periods` | `list` |
| `Vindi::Transaction` | `transactions` | `list`, `create` |
| `Vindi::Usage` | `usages` | `list`, `create`, `delete` |
| `Vindi::Invoice` | `invoices` | `list` |
| `Vindi::Movement` | `movements` | `list` |
| `Vindi::Message` | `messages` | `list` |
| `Vindi::ExportBatch` | `export_batches` | `list`, `create` |
| `Vindi::ImportBatch` | `import_batches` | `list`, `create` |
| `Vindi::Issue` | `issues` | `list`, `update` |
| `Vindi::Notification` | `notifications` | `list` |
| `Vindi::Merchant` | `merchants` | `list` |
| `Vindi::MerchantUser` | `merchant_users` | `list` |
| `Vindi::Role` | `roles` | `list` |
| `Vindi::User` | `users` | `list` |
| `Vindi::Public` | `public` | None (Static Config) |
| `Vindi::Affiliate` | `affiliates` | `list` |
| `Vindi::Partner` | `partner` | `list` |

---

## 3. Usage Examples

### Customers (`Vindi::Customer`)

```ruby
# Create a customer
customer = Vindi::Customer.create(
  name: "John Doe",
  email: "john@example.com"
)

# Fetch attribute
puts customer.id
puts customer.name

# Update customer
updated = Vindi::Customer.update(customer.id, email: "john.new@example.com")

# Delete customer
Vindi::Customer.delete(customer.id)
```

### Payment Profiles (`Vindi::PaymentProfile`)

```ruby
# Create a card payment profile
profile = Vindi::PaymentProfile.create(
  customer_id: 12345,
  payment_company_code: "visa",
  holder_name: "JOHN DOE",
  card_number: "4111111111111111",
  card_expiration_date: "12/2030",
  card_cvv: "123"
)

# Delete payment profile
Vindi::PaymentProfile.delete(profile.id)
```

### Subscriptions (`Vindi::Subscription`)

```ruby
# Create subscription
subscription = Vindi::Subscription.create(
  customer_id: customer.id,
  plan_id: plan.id,
  payment_method_code: "credit_card"
)

# Cancel/Delete subscription
Vindi::Subscription.delete(subscription.id)
```

### Charges (`Vindi::Charge`)

```ruby
# List charges
charges = Vindi::Charge.list(status: "pending")

# Charge details
puts charges.first.amount
```

### Plans (`Vindi::Plan`)

```ruby
# Create a plan
plan = Vindi::Plan.create(
  name: "Premium Gold Plan",
  code: "gold_premium",
  interval: "months",
  interval_count: 1
)

# List plans
plans = Vindi::Plan.list
```

### Products & Product Items (`Vindi::Product` & `Vindi::ProductItem`)

```ruby
# Create a product
product = Vindi::Product.create(
  name: "Hosting Service",
  code: "hosting"
)

# Associate a product to a plan/subscription
product_item = Vindi::ProductItem.create(
  product_id: product.id,
  plan_id: plan.id
)
```

### Discounts (`Vindi::Discount`)

```ruby
# Create/apply a discount
discount = Vindi::Discount.create(
  amount: 15.00,
  discount_type: "percentage",
  percentage: 10
)
```

### Bills & Bill Items (`Vindi::Bill` & `Vindi::BillItem`)

```ruby
# Create a bill manually
bill = Vindi::Bill.create(
  customer_id: customer.id,
  payment_method_code: "credit_card",
  bill_items: [
    { product_id: product.id, amount: 99.90 }
  ]
)

# List bill items
items = Vindi::BillItem.list(bill_id: bill.id)
```

### Periods (`Vindi::Period`)

```ruby
# List subscription periods
periods = Vindi::Period.list(subscription_id: subscription.id)
```

### Transactions (`Vindi::Transaction`)

```ruby
# Create a manual transaction/charge capture
transaction = Vindi::Transaction.create(
  charge_id: charge.id,
  amount: 99.90
)

# List transactions
transactions = Vindi::Transaction.list
```

### Usages (`Vindi::Usage`)

```ruby
# Report a metered usage for a subscription
usage = Vindi::Usage.create(
  subscription_id: subscription.id,
  quantity: 50,
  description: "API Calls consumed"
)

# List usages
usages = Vindi::Usage.list(subscription_id: subscription.id)
```

### Invoices (`Vindi::Invoice`)

```ruby
# List invoices
invoices = Vindi::Invoice.list(status: "issued")
```

### Issues (`Vindi::Issue`)

```ruby
# Update an issue status (e.g. resolve a billing conflict)
issue = Vindi::Issue.update(issue_id, status: "resolved")
```

### Import/Export Batches (`Vindi::ImportBatch` & `Vindi::ExportBatch`)

```ruby
# Start a new customer/subscription import batch
import_batch = Vindi::ImportBatch.create(
  batch_type: "customer",
  file_url: "https://example.com/import.csv"
)

# Request a data export batch
export_batch = Vindi::ExportBatch.create(
  batch_type: "bill"
)
```

---

## 4. Extensible Companion Gems

To keep the core SDK lightweight and dependency-free, Rails-specific features are distributed via companion gems.

### 4.1 Backend Integrations ([`vindi-rails-integrations`](https://github.com/wesleyskap/vindi-rails-integrations))

Provides automatic ActiveRecord model synchronization, webhook controller endpoints, background processing jobs, and administration Rake tasks.

#### Installation
Add it to your Gemfile:
```ruby
gem 'vindi-rails-integrations'
```

#### Webhook Setup
Generate the webhook endpoint controller and processing job in your host application:
```bash
bundle exec rails generate vindi:webhook
```

##### 1. Webhooks Controller (`app/controllers/vindi/webhooks_controller.rb`)
Validates incoming Vindi HTTP POST notifications by checking a secure token inside the query parameters.
- **Webhook Endpoint**: `POST /vindi/webhooks?token=YOUR_SECURE_TOKEN`
- **Controller Response**: Returns `{ "status": "received" }` with HTTP status `200 OK` on success, or `{ "error": "Unauthorized access token" }` (`401 Unauthorized`) / `{ "error": "Invalid payload" }` (`400 Bad Request`).

##### 2. Asynchronous Webhook Job (`app/jobs/vindi/webhook_job.rb`)
Handles processing events in the background. It includes built-in safeguards like idempotency checking.

##### 3. Modular Webhook Handlers
For cleaner architectures, separate processing of each event type into dedicated service files:
```bash
bundle exec rails generate vindi:webhook_handler subscription_canceled
```
This generates `app/services/vindi/webhooks/base_handler.rb` (base class) and `app/services/vindi/webhooks/subscription_canceled_handler.rb`. The generated `WebhookJob` will automatically discover and dispatch to these modular classes dynamically.

###### Example Vindi Webhook Payload (Event)
```json
{
  "event": {
    "id": 1928374,
    "type": "bill_paid",
    "created_at": "2026-06-10T15:00:00.000-03:00",
    "data": {
      "bill": {
        "id": 887766,
        "amount": "150.00",
        "status": "paid",
        "customer": {
          "id": 112233,
          "name": "Jane Doe",
          "email": "jane.doe@example.com",
          "code": "user_42"
        }
      }
    }
  }
}
```

#### ActiveRecord Synchronization
Map any ActiveRecord model (e.g., `User`, `Account`) to synchronize automatically with Vindi Customers.

##### 1. Generator Setup
Run the sync generator for your model:
```bash
bundle exec rails generate vindi:sync User
```
This generates a database migration to add `vindi_customer_id` (String) to your users table and configures the `Vindi::Synchronizable` concern.

##### 2. Usage & Override Customization
Include `Vindi::Synchronizable` in your model and customize the attributes payload sent to Vindi:
```ruby
class User < ApplicationRecord
  include Vindi::Synchronizable

  # Optional: Customize the attributes synced with Vindi
  def vindi_customer_attributes
    {
      name: "#{first_name} #{last_name}",
      email: email,
      registry_code: cpf_or_cnpj, # If applicable
      code: "user_#{id}"
    }
  end
end
```

When a user record is committed on create or update, it triggers:
- **On Create**: Calls `Vindi::Customer.create` and populates `vindi_customer_id` automatically in your database.
- **On Update**: Automatically checks if `name` or `email` changed, and triggers `Vindi::Customer.update` to keep records in sync.

#### Rake Tasks
The gem includes task commands for verification:

##### 1. Auditing (`vindi:audit`)
Reconcile your local ActiveRecord model records against Vindi customers API:
```bash
bundle exec rake vindi:audit model=User
```
**Example Audit Output Log:**
```text
Analyzing User database...
[Audit] Checking User ID: 42 (Vindi ID: 112233) - Match found.
[Audit] Checking User ID: 43 (Vindi ID: nil) - Missing in Vindi!
[Audit Warning] User ID 43 created in Vindi with customer ID 112234.
Reconciliation complete. 1 missing records synchronized.
```

##### 2. Local Webhook Test Simulator (`vindi:test_webhook`)
Simulate webhook event POST requests to your Rails environment locally:
```bash
bundle exec rake vindi:test_webhook event=bill_paid url=http://localhost:3000/vindi/webhooks token=YOUR_SECURE_TOKEN
```
**Example Request Sent:**
```text
Sending POST to http://localhost:3000/vindi/webhooks?token=YOUR_SECURE_TOKEN...
Payload: {"event":{"id":9999,"type":"bill_paid","data":{...}}}
Response Code: 200 OK
Response Body: {"status":"received"}
```

##### 3. Diagnostics and Connectivity Check (`vindi:status`)
Verify your configured API environments, credentials safely (masked), and run connectivity health checks:
```bash
bundle exec rake vindi:status
```
**Example Status Report:**
```text
=== Vindi Integration Status ===
Environment: Sandbox
API URL:     https://sandbox-gp.vindi.com.br/api/v1
API Key:     *****2345
Webhook:     *****_999
--------------------------------
Connectivity: SUCCESS
================================
```

---

### 4.2 Frontend Engines ([`vindi-rails-engines`](https://github.com/wesleyskap/vindi-rails-engines))

Mountable UI resources providing PCI-compliant client side tokenization components.

#### Installation
Add it to your Gemfile:
```ruby
gem 'vindi-rails-engines'
```

#### Checkout UI Setup
Initialize the tokenization view templates and stimulus controllers:
```bash
bundle exec rails generate vindi:checkout
```

##### 1. Stimulus JS Controller (`app/javascript/controllers/vindi_checkout_controller.js`)
Intercepts the form submission, serializes card inputs, interacts with Vindi's public tokenization client, and sets the returned token into a hidden field:
```javascript
// Connects to data-controller="vindi-checkout"
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "publicKey", "holderName", "cardNumber", "expiry", "cvv", "tokenInput" ]

  tokenizeCard(event) {
    event.preventDefault()
    const vindi = new Vindi(this.publicKeyTarget.value)
    
    vindi.createToken({
      holder_name: this.holderNameTarget.value,
      card_number: this.cardNumberTarget.value.replace(/\s+/g, ''),
      card_expiration: this.expiryTarget.value,
      card_cvv: this.cvvTarget.value
    }).then((response) => {
      // response: { token: "tok_abc123XYZ", created_at: "2026-06-10..." }
      this.tokenInputTarget.value = response.token
      this.element.submit()
    }).catch((error) => {
      alert("Tokenization Error: " + error.message)
    })
  }
}
```

##### 2. Vindi Public Key Response Example
When calling `vindi.createToken(...)` with card credentials, the Javascript SDK returns the payment profile token:
```json
{
  "token": "tok_3278918239abc",
  "created_at": "2026-06-10T16:50:00.000-03:00"
}
```

Use the generated `payment_profile_token` in your backend controllers to safely set up new subscriptions or charge invoices without storing credit card details locally:
```ruby
# Example Controller endpoint processing checkout token
def charge
  Vindi::Charge.create(
    payment_method_code: "credit_card",
    payment_profile: {
      token: params[:payment_profile_token]
    },
    amount: "150.00",
    customer_id: current_user.vindi_customer_id
  )
end
```

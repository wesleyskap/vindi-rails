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

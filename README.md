# Vindi Rails SDK

[Leia em Português (README.pt-BR.md)](./README.pt-BR.md)

Ruby/Rails integration SDK for the Vindi API v1 (recurring billing platform).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'vindi-rails'
```

And then execute:

```bash
$ bundle install
```

## Configuration

Configure the SDK. In a Rails application, you can run the installation generator to create the initializer template:

```bash
$ rails generate vindi:install
```

This will create `config/initializers/vindi.rb` where you can set your keys:

```ruby
Vindi.configure do |config|
  config.api_key = 'your_private_api_key'
  # Optional: Define base URL (default is Sandbox)
  # config.api_url = 'https://gp.vindi.com.br/api/v1'
end
```

## Usage

Resources are mapped directly under the `Vindi` namespace.

### Customers

```ruby
# List customers
customers = Vindi::Customer.list(page: 1, per_page: 20)

# Create a customer
customer = Vindi::Customer.create(
  name: 'John Doe',
  email: 'john.doe@example.com',
  registry_code: '12345678909' # CPF/CNPJ
)

# Update a customer
Vindi::Customer.update(customer.id, name: 'John Doe Updated')

# Delete a customer
Vindi::Customer.delete(customer.id)
```

## Extensible Rails Integrations & Engines

To keep the SDK lightweight and free of framework dependencies, Rails-specific features are organized into extensible companion gems:

### 1. Backend Integrations ([`vindi-rails-integrations`](https://github.com/wesleyskap/vindi-rails-integrations))
Handles webhook processing, background jobs, and ActiveRecord synchronization:
- **`rails generate vindi:webhook`**: Creates a webhooks controller and background queue job stub to process payment/subscription events safely with built-in security filters and idempotency checks.
- **`rails generate vindi:webhook_handler [EventName]`**: Generates a modular event-specific service handler class (e.g. for `subscription_canceled`), which is automatically dispatched by the main `WebhookJob`.
- **`rails generate vindi:sync [Model]`**: Adds `vindi_customer_id` and database migrations to synchronize your models (e.g. `User`) automatically with Vindi via ActiveRecord callbacks.
- **`rails vindi:status`**: A diagnostics Rake task to safely check configured Vindi API credentials, active environments, and verify connectivity.

### 2. Frontend Engines ([`vindi-rails-engines`](https://github.com/wesleyskap/vindi-rails-engines))
A mountable Rails Engine carrying pre-built Views, HTML templates, and card tokenization scripts:
- **`rails generate vindi:checkout`**: Copies ready-to-use checkout UI templates and Stimulus JS components using Vindi's public keys encryption.

For detailed integration guides, please refer to [WIKI.md](./WIKI.md).

## Running Tests with Docker Compose

To build and run the Minitest test suite inside Docker:

```bash
docker compose build
docker compose run --rm test
```

## Detailed Documentation

For a full list of mapped resources and detailed usage instructions, check out the [WIKI.md](./WIKI.md).

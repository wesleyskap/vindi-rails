# Vindi Rails SDK

[Leia em Português (README.pt-BR.md)](./README.pt-BR.md)

Ruby/Rails integration SDK for the Vindi API v1 (recurring billing platform).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'vindi-rails', path: 'c:/Users/User/develop/estudo/vindi-rails'
```

And then execute:

```bash
$ bundle install
```

## Configuration

Configure the SDK using a Rails initializer or before using it:

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

## Running Tests with Docker Compose

To build and run the Minitest test suite inside Docker:

```bash
docker compose build
docker compose run --rm test
```

## Detailed Documentation

For a full list of mapped resources and detailed usage instructions, check out the [WIKI.md](./WIKI.md).

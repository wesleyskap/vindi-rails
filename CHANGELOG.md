# Changelog

All notable changes to this project will be documented in this file.

---
## [0.4.0] - 2026-06-15

### Added
- **Rate Limit & Auto-Retry**: Automated retry handling with exponential backoff for HTTP 429 (Rate Limit) responses and temporary connection timeouts. Respects the `Retry-After` header when provided.
- **Caching**: Built-in, configurable caching mechanism for static/rarely-changing resources (Plans, Products, Discounts, Payment Methods) to minimize redundant network requests.

## [0.3.0] - 2026-06-13

### Added
- **Idempotency Key Support**: Support for `Idempotency-Key` headers on POST/PUT actions via optional `opts` parameter in `.create` and `.update` operations.
- **Docker Caching Improvement**: Copy `Gemfile.lock` during the dependencies caching build step inside `Dockerfile` to prevent runtime version mismatch issues.

## [0.2.1] - 2026-06-12

### Changed
- **Documentation**: Updated README and WIKI (both EN and PT-BR) to document the new modular webhook handlers features provided by the companion `vindi-rails-integrations` gem.

## [0.2.0] - 2026-06-10

### Added
- **Rails Generator**: Added `rails generate vindi:install` command to easily bootstrap the initializer configuration.

---

## [0.1.0] - 2026-06-10

### Added
- **Core SDK**: Initial release of the Vindi Rails SDK using `RestClient` as the default adapter.
- **Resources**: Map all 28 API resources, with complete CRUD operations and Minitest coverage implemented for all of them, including core billing, catalog (plans/products), billing/transactions, and administration/batch endpoints.
- **Dockerization**: Dockerfile and docker-compose.yml configuration to run the test suite isolated.
- **Testing**: Test suite using Minitest and WebMock (23 test runs, 44 assertions).
- **Documentation**: Detailed bilingual WIKI (EN / PT-BR) and README configuration/usage guides.

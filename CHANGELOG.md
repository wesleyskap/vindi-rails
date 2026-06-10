# Changelog

All notable changes to this project will be documented in this file.

---

## [0.1.0] - 2026-06-10

### Added
- **Core SDK**: Initial release of the Vindi Rails SDK using `RestClient` as the default adapter.
- **Resources**: Map all 28 API resources, with complete CRUD operations and Minitest coverage implemented for all of them, including core billing, catalog (plans/products), billing/transactions, and administration/batch endpoints.
- **Dockerization**: Dockerfile and docker-compose.yml configuration to run the test suite isolated.
- **Testing**: Test suite using Minitest and WebMock (23 test runs, 44 assertions).
- **Documentation**: Detailed bilingual WIKI (EN / PT-BR) and README configuration/usage guides.

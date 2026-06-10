---
trigger: manual
---

# Rails Engineering Guidelines
## Code Style
* Functions: 4-20 lines. Split if longer.
* Files: under 500 lines. Split by responsibility.
* One thing per function, one responsibility per module (SRP).
* Names: specific and unique. Avoid `data`, `handler`, `manager`, `service`. Prefer names that describe a business action.
* No code duplication. Extract shared logic into a function/module.
* Early returns over nested ifs. Max 2 levels of indentation.
* Exception messages must include the offending value and expected shape.
* Prefer immutable data flow when possible.
* Avoid metaprogramming unless it clearly reduces complexity.
## Rails Architecture
* Controllers orchestrate. Business rules belong elsewhere.
* Controllers should stay under ~30 lines per action.
* Models own persistence and simple validations.
* Complex business rules belong in Service Objects.
* Service Objects should represent actions (`CreateOrder`, `CancelSubscription`, `ImportCustomers`).
* Avoid generic classes such as `UserService`, `OrderManager`, `PaymentHandler`.
* Query logic reused more than once belongs in Query Objects.
* Form Objects should encapsulate complex input validation and transformations.
* Prefer composition over inheritance.
## Active Record
* Keep models focused and small (<300 lines preferred).
* Avoid Fat Models.
* Validations belong in models; workflows belong in services.
* Always evaluate queries for N+1 risks.
* Use `includes`, `preload`, or `eager_load` when appropriate.
* Prefer scopes only for simple reusable queries.
* Avoid `default_scope`.
* Use database constraints in addition to model validations.
* Every foreign key should have a database constraint when possible.
* Every frequently queried column should be reviewed for indexing.
## Database
* All migrations must be reversible.
* Use transactions when modifying multiple entities.
* Prefer database constraints over application-only guarantees.
* Avoid loading large datasets into memory.
* Use `find_each` for batch processing.
* Use `pluck` when only specific columns are needed.
* Prefer explicit column selection over loading full records.
## Background Jobs
* Jobs orchestrate; business logic lives in services.
* Jobs should be idempotent.
* Jobs must be retry-safe.
* External API calls should happen asynchronously when possible.
* Long-running work should always be delegated to jobs.
## Events & Messaging
* Prefer event-driven communication over direct service coupling.
* Commands change state.
* Events communicate state changes.
* Event names should be business-oriented (`OrderCreated`, `PaymentApproved`).
* Consumers must be idempotent.
* Use correlation IDs across services.
## Callbacks
* Use callbacks only for simple model concerns.
* Avoid callbacks for external integrations.
* Avoid callback chains that hide business flow.
* Prefer explicit service orchestration over lifecycle callbacks.
## Testing
* Tests run with a single command: `<project-specific>`.
* Every new function gets a test.
* Bug fixes get a regression test.
* Tests must be F.I.R.S.T.
* Prefer request specs for APIs.
* Test behavior, not implementation details.
* Do not test private methods directly.
* Factories should create only required data.
* Avoid excessive fixture setup.
## Dependencies
* Inject dependencies through constructor/parameter, not global state.
* Wrap third-party libraries behind project-owned interfaces.
* Never couple business logic directly to framework APIs when abstraction is reasonable.
* External integrations should be replaceable through adapters.
## Structure
* Follow Rails conventions before introducing custom patterns.
* Prefer small focused modules over god files.
* Predictable paths and responsibilities.
* Services, Queries, Policies, Forms and Jobs should each have a clear responsibility.
* Keep domain logic close to the domain it belongs to.
## Performance
* Every new query should be reviewed for N+1 issues.
* Monitor slow queries.
* Avoid unnecessary object allocations.
* Cache only after measuring.
* Prefer database operations over Ruby loops for large datasets.
* Measure before optimizing.
## Logging & Observability
* Structured JSON logging for systems and integrations.
* Include request ID and correlation ID.
* Log business events, not only technical failures.
* External calls must log duration, status and failures.
* Use metrics and tracing for critical flows.
* Never log secrets, tokens, credentials or personal data.
## Formatting
* Use the language default formatter (`rubocop -A`).
* Do not debate formatting in code reviews unless readability or correctness is affected.
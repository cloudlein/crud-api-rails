# Feature Implementation Roadmap: Simple CRUD to Mid-Level API

This roadmap focuses on evolving the current simple Book CRUD API into a robust, mid-level production-ready application by systematically adding features and architectural improvements.

## Phase 1: The Foundation (Completed)
*Objective: Establish basic data management.*
- [x] Setup Rails API project with PostgreSQL using Docker Compose.
- [x] Create `Book` model with basic attributes (title, author, genre).
- [x] Implement standard CRUD operations in `BooksController`.

## Phase 2: Relational Data (Completed)
*Objective: Manage relational data between Books, Authors, and Genres.*
- [x] Extract `Author` model and establish one-to-many relationship.
- [x] Extract `Genre` model and establish many-to-many relationship via `BookGenres`.
- [x] Implement nested routing for `authors/:author_id/books` and `genres/:genre_id/books`.

## Phase 3: Advanced Querying (Pending)
*Objective: Optimize API for consumption using Query Objects.*
- [ ] **Pagination**: Implement pagination using `pagy`.
- [ ] **Filtering & Sorting**: Implement search and sort logic within dedicated Query Objects.
- [ ] **N+1 Prevention**: Audit and optimize endpoints to use `.includes` for relational loading.

## Phase 4: Error Handling & Serialization (Pending)
*Objective: Standardize API responses and decouple formatting.*
- [ ] **Standardized Error Handling**: Extract rescue logic into a dedicated `ErrorHandler` module in `ApplicationController`.
- [ ] **Serializers**: Introduce a serialization layer (e.g., `Blueprinter`) to decouple response formatting from controllers.

## Phase 5: Authentication & Authorization (Pending)
*Objective: Secure the API with JWT and RBAC.*
- [ ] **JWT Auth**: Implement user authentication.
- [ ] **Endpoint Protection**: Secure CUD operations.
- [ ] **RBAC**: Add role management for granular access.

## Phase 6: Service Objects, Jbuilder & Async (Pending)
*Objective: Encapsulate business logic and JSON serialization.*
- [ ] **Jbuilder**: Implement Jbuilder templates to handle JSON response serialization and formatting.
- [ ] **Service Objects**: Refactor complex controller actions (e.g., `BookCreation`) into focused Service Objects.
- [ ] **Background Jobs**: Integrate `SolidQueue` for asynchronous operations.

## Phase 7: Testing & Documentation (Pending)
*Objective: Ensure quality and discoverability.*
- [ ] **RSpec/FactoryBot**: Migrate or extend test suite to RSpec.
- [ ] **Request Specs**: Add comprehensive integration tests.
- [ ] **OpenAPI/Swagger**: Integrate `rswag` for automated documentation.

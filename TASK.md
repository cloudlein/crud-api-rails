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

## Phase 3: Advanced Querying (In Progress)
*Objective: Optimize API for consumption.*
- [x] **Pagination**: Implement pagination using `pagy` (OffsetPaginator) across Books, Authors, Genres.
- [x] **DRY Pagination**: Extract Pagy logic into `Paginatable` concern.
- [ ] **Filtering & Sorting**: Implement search and sort logic within dedicated Query Objects.
- [ ] **N+1 Prevention**: Audit and optimize endpoints to use `.includes` for relational loading.

## Phase 4: Error Handling & Serialization (Completed)
*Objective: Standardize API responses and decouple formatting.*
- [x] **Standardized Error Handling**: Centralized rescue logic in `ApplicationController`:
  - `ActiveRecord::RecordNotFound` → 404 with dynamic model name (`e.model`)
  - `ActiveRecord::RecordInvalid` → 422 with full validation messages
  - `ActionDispatch::Http::Parameters::ParseError` → 400 for malformed JSON body
- [x] **Model Validations**: Added validations to `Book`, `Genre`, and `Author` models.
- [x] **Jbuilder**: Implemented Jbuilder templates for all resources (Books, Authors, Genres) with shared `_pagination_meta` partial.

## Phase 5: Authentication & Authorization (Pending)
*Objective: Secure the API with JWT and RBAC.*
- [ ] **JWT Auth**: Implement user authentication.
- [ ] **Endpoint Protection**: Secure CUD operations.
- [ ] **RBAC**: Add role management for granular access.

## Phase 6: Service Objects & Async (Pending)
*Objective: Encapsulate business logic.*
- [ ] **Service Objects**: Refactor complex controller actions (e.g., `BookCreation`) into focused Service Objects.
- [ ] **Background Jobs**: Integrate `SolidQueue` for asynchronous operations.

## Phase 7: Testing & Documentation (Pending)
*Objective: Ensure quality and discoverability.*
- [ ] **RSpec/FactoryBot**: Migrate or extend test suite to RSpec.
- [ ] **Request Specs**: Add comprehensive integration tests.
- [ ] **OpenAPI/Swagger**: Integrate `rswag` for automated documentation.

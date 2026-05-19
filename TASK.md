# Feature Implementation Roadmap: Simple CRUD to Mid-Level API

This roadmap focuses on evolving the current simple Book CRUD API into a robust, mid-level production-ready application by systematically adding features and architectural improvements.

## Phase 1: The Foundation (Completed)
*Objective: Establish basic data management.*
- [x] Setup Rails API project with PostgreSQL using Docker Compose.
- [x] Create `Book` model with basic attributes (title, author, genre).
- [x] Implement standard CRUD operations in `BooksController`.

## Phase 2: Relational Data (Beginner-Intermediate)
*Objective: Move beyond flat tables and manage relational data.*
- [x] **Extract Author Model**: Create an `Author` model and establish a one-to-many relationship (`Author has_many :books`, `Book belongs_to :author`). 
- [x] **Extract Category/Genre Model**: Create a `Genre` model and establish a many-to-many relationship using a join table (`Book has_many :genres, through: :book_genres`).
- [x] **Nested Routing**: Update routes to support nested resources based on the database design:
  - [x] `GET /authors/:author_id/books` (List all books written by a specific author)
  - [x] `GET /genres/:genre_id/books` (List all books belonging to a specific genre)

## Phase 3: Advanced Querying (Intermediate)
*Objective: Make the API practical for frontend consumption.*
- [ ] **Pagination**: Implement pagination for the `index` endpoints using a gem like `pagy` or `kaminari` to prevent fetching thousands of records at once.
- [ ] **Filtering**: Allow users to filter books (e.g., `GET /books?category=fiction&year=2023`).
- [ ] **Sorting**: Allow users to sort results (e.g., `GET /books?sort=-created_at`).
- [ ] **N+1 Query Prevention**: Ensure endpoints using relationships (like fetching books with their authors) use `.includes()` to prevent N+1 database queries.

## Phase 4: Data Integrity & Error Handling (Intermediate)
*Objective: Ensure data quality and predictable API responses.*
- [ ] **Complex Validations**: Add custom validations (e.g., a book title must be unique for a specific author; publication date cannot be in the future).
- [ ] **Standardized Error Responses**: Extract error handling (`rescue_from`) into a generic `ErrorHandler` module or `ApplicationController` to ensure all API errors (404, 422, 500) share the exact same JSON structure.

## Phase 5: Authentication & Authorization (Intermediate)
*Objective: Secure the API and manage user permissions.*
- [ ] **User Authentication**: Implement a `User` model and secure endpoints using JSON Web Tokens (JWT).
- [ ] **Endpoint Protection**: Require valid JWT tokens to Create, Update, or Delete resources, while keeping Read (`index`/`show`) public.
- [ ] **Role-Based Access Control (RBAC)**: Add roles to users (e.g., `admin`, `member`). Ensure only `admin` users can delete records.

## Phase 6: Architecture & Refactoring (Mid-Level)
*Objective: Decouple logic to make the codebase maintainable as it grows.*
- [ ] **Serializers**: Replace manual `render json:` hashes with a dedicated serialization library (like `Blueprinter` or `ActiveModel::Serializers`) to format API responses.
- [ ] **Service Objects**: Move complex business logic out of the controller. For example, create a `BookCreationService` that handles creating a book, assigning categories, and handling failures in a single transaction.
- [ ] **Background Jobs**: Integrate `Sidekiq` or `SolidQueue` to handle asynchronous tasks. Example task: Whenever a new Book is created, queue a background job to send a notification email to Users who follow that Author.

## Phase 7: Testing & Documentation (Mid-Level)
*Objective: Prove the API works and make it easy for others to use.*
- [ ] **Test Setup**: Install and configure `RSpec` and `FactoryBot`.
- [ ] **Unit Testing**: Write unit tests (Model specs) for your database validations, relationships, and custom methods. Write unit tests for your Service Objects to verify isolated business logic.
- [ ] **Integration Testing**: Write Request specs for every API endpoint to verify HTTP status codes, correct routing, and accurate JSON response payloads.
- [ ] **API Documentation**: Integrate `rswag` to automatically generate an interactive Swagger/OpenAPI UI directly from your Request specs.

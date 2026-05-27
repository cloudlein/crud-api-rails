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

## Phase 3: Advanced Querying (Completed)
*Objective: Optimize API for consumption.*
- [x] **Pagination**: Implement pagination using `pagy` (OffsetPaginator) across Books, Authors, Genres.
- [x] **DRY Pagination**: Extract Pagy logic into `Paginatable` concern.
- [x] **Filtering & Sorting**: Implement search and sort logic within dedicated Query Objects (`AuthorQuery`, `BookQuery`, `GenreQuery`).
- [x] **N+1 Prevention**: Audit and optimize endpoints to use `.includes` for relational loading.

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

### 5.0 Pre-requisite: `users` Table
*Schema for the `users` table that backs JWT auth and RBAC.*

```
Table: users
┌──────────────┬─────────────────────────┬─────────────────────────────────────────────┐
│ Column       │ Type                    │ Notes                                       │
├──────────────┼─────────────────────────┼─────────────────────────────────────────────┤
│ id           │ bigint (PK)             │ auto-increment                              │
│ name         │ string      NOT NULL    │ display name                                │
│ email        │ string      NOT NULL    │ unique index                                │
│ password_digest│ string    NOT NULL    │ bcrypt hash via has_secure_password         │
│ role         │ string      NOT NULL    │ default: 'user' — enum: user / admin        │
│ created_at   │ datetime    NOT NULL    │                                             │
│ updated_at   │ datetime    NOT NULL    │                                             │
└──────────────┴─────────────────────────┴─────────────────────────────────────────────┘
Indexes: index_users_on_email (unique)
```

- [ ] **Create `users` migration**: `rails g model User name:string email:string:uniq password_digest:string role:string`
  - Add `default: 'user'` and `null: false` constraints in migration.
  - Add `has_secure_password` + `validates :email, uniqueness: true` in model.
- [ ] **JWT Auth**: Implement user authentication (register / login → return JWT token).
- [ ] **Endpoint Protection**: Secure CUD operations with `before_action :authenticate_user!`.
- [ ] **RBAC**: Add role management — admin-only access for destructive actions.

## Phase 6: Service Objects & Async (Pending)
*Objective: Encapsulate business logic.*
- [ ] **Service Objects**: Refactor complex controller actions (e.g., `BookCreation`) into focused Service Objects.
- [ ] **Background Jobs**: Integrate `SolidQueue` for asynchronous operations.

## Phase 7: Testing & Documentation (Pending)
*Objective: Ensure quality and discoverability.*

### Unit Tests
- [ ] **Setup RSpec & FactoryBot**
  - Add `rspec-rails`, `factory_bot_rails`, `faker`, `shoulda-matchers` to `Gemfile`.
  - Run `rails generate rspec:install`.
  - Configure `FactoryBot` syntax methods in `spec/rails_helper.rb`.
- [ ] **Model Specs** (`spec/models/`)
  - `user_spec.rb` — validations (presence, email uniqueness, role default), `has_secure_password`.
  - `book_spec.rb` — presence/length validations, associations (`belongs_to :author`, HABTM genres).
  - `author_spec.rb` — presence validations, `has_many :books` association.
  - `genre_spec.rb` — presence/uniqueness validations, `has_and_belongs_to_many :books`.
- [ ] **Query Object Specs** (`spec/queries/`)
  - `book_query_spec.rb` — filtering by title/author/genre, sorting asc/desc.
  - `author_query_spec.rb` — filtering by name, sorting.
  - `genre_query_spec.rb` — filtering by name.
- [ ] **Controller / Request Specs** (`spec/requests/`)
  - `books_spec.rb` — CRUD happy paths + validation errors + 404 handling.
  - `authors_spec.rb` — CRUD + nested `authors/:id/books` endpoint.
  - `genres_spec.rb` — CRUD + nested `genres/:id/books` endpoint.
  - `sessions_spec.rb` *(Phase 5)* — login success, invalid credentials → 401.
  - Protected endpoints → 401 without token, 403 for insufficient role.
- [ ] **Factories** (`spec/factories/`)
  - `users.rb`, `books.rb`, `authors.rb`, `genres.rb`.

### Documentation
- [ ] **OpenAPI/Swagger**: Integrate `rswag` for automated API documentation.

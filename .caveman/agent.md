# AI Agent Context

## Project Overview

This is a Ruby on Rails application using a service-oriented architecture.

Main goals:
- keep controllers thin
- move business logic into services
- keep models focused on persistence and associations
- prefer explicit code over Rails magic when complexity grows

---

# Tech Stack

- Ruby on Rails
- PostgreSQL
- RSpec
- Sidekiq
- Redis
- Docker
- REST API architecture

---

# Architecture Rules

## Controllers

Controllers should:
- validate request input
- call services/use cases
- render JSON responses
- avoid business logic

Bad:
```rb
def create
  user = User.create!(params)
  send_email(user)
end
```

Good:
```rb
def create
  result = Users::CreateService.call(user_params)
  render json: result
end
```

---

## Models

Models should contain:
- associations
- scopes
- simple validations
- lightweight domain helpers

Avoid:
- external API calls
- complex orchestration
- multi-step workflows

---

## Services

Business logic belongs in:
```txt
app/services
```

Convention:
```txt
Namespace::ActionService
```

Examples:
```txt
Users::CreateService
Books::PublishService
Payments::ChargeService
```

Service structure:
```rb
class Users::CreateService
  def self.call(params)
    new(params).call
  end

  def initialize(params)
    @params = params
  end

  def call
    # business logic
  end
end
```

---

# API Response Convention

Success:
```json
{
  "data": {}
}
```

Error:
```json
{
  "error": {
    "message": "Something went wrong"
  }
}
```

---

# Database Conventions

## Naming

Use:
- snake_case
- singular model names
- plural table names

Examples:
- User -> users
- Book -> books

---

## Associations

Use explicit associations.

Example:
```rb
class Book < ApplicationRecord
  belongs_to :author
end

class Author < ApplicationRecord
  has_many :books
end
```

---

# Folder Structure

```txt
app/
├── controllers/
├── models/
├── services/
├── serializers/
├── jobs/
├── policies/
```

---

# Testing Rules

Use RSpec.

Prefer:
- request specs for endpoints
- service specs for business logic
- model specs only for validations/scopes

Avoid excessive mocking unless necessary.

---

# Performance Rules

Avoid:
- N+1 queries
- loading unnecessary associations
- fat JSON serialization

Prefer:
```rb
includes(:author)
select(:id, :title)
```

---

# Coding Style

Prefer:
- readable code
- small methods
- early returns
- explicit naming

Avoid:
- deep nesting
- metaprogramming unless necessary
- hidden side effects

Bad:
```rb
do_this if condition
```

Prefer:
```rb
return unless condition

do_this
```

---

# Security Rules

Never:
- trust raw params
- expose sensitive fields
- interpolate SQL manually

Always use:
```rb
params.require(...).permit(...)
```

---

# AI Instructions

When analyzing code:
- do not rewrite entire files unless requested
- prefer minimal changes
- explain reasoning before suggesting refactors
- preserve existing architecture patterns
- avoid introducing unnecessary gems

When generating code:
- follow existing naming conventions
- avoid overengineering
- keep Rails conventions unless project already deviates

---

# Important Files

Main routes:
```txt
config/routes.rb
```

Environment config:
```txt
config/environments/
```

Database schema:
```txt
db/schema.rb
```

Service layer:
```txt
app/services/
```

---

# Token Optimization Notes

To reduce token usage:
- prioritize reading:
  1. routes
  2. schema
  3. target feature files
- avoid scanning entire project
- avoid reading generated files
- avoid reading logs/node_modules/tmp/storage

Ignore:
```txt
log/
tmp/
storage/
node_modules/
coverage/
vendor/bundle/
```

---

# Workflow

Before coding:
1. understand feature scope
2. inspect related routes/models/services only
3. avoid unrelated files

Before refactoring:
1. explain problem
2. explain tradeoff
3. suggest minimal safe change

---

# Output Preference

Prefer:
- concise explanations
- focused diffs
- incremental changes

Avoid:
- rewriting architecture
- large speculative refactors
- unnecessary abstractions
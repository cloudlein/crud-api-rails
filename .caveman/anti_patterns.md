# Anti Patterns

Never:

* put business logic in controllers
* create fat models
* use callbacks for complex workflows
* duplicate query logic
* rescue Exception broadly
* use global state

Avoid:

* unnecessary service objects
* premature abstraction
* deep inheritance
* metaprogramming without strong reason
* callbacks with side effects

Controllers should not:

* contain query logic
* contain transaction logic
* contain complex conditionals

Models should not:

* orchestrate external services
* contain unrelated responsibilities

Services should not:

* become God objects
* know too much about HTTP layer

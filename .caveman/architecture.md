# Architecture

This project uses Rails conventions with lightweight service-oriented architecture.

Main principles:

* controllers stay thin
* models handle persistence
* business workflows go into services
* queries belong in query objects if complex
* serializers handle response formatting

Structure:

* controllers/

    * request handling only
* models/

    * persistence and simple domain logic
* services/

    * business workflows
* queries/

    * complex database queries
* serializers/

    * API response formatting

Rules:

* avoid fat controllers
* avoid fat models
* avoid business logic in views
* keep services focused on one responsibility
* prefer Rails conventions before introducing abstractions

Database:

* PostgreSQL
* ActiveRecord ORM

API:

* JSON API responses

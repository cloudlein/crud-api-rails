# CRUD API Rails

This is a Ruby on Rails API project.

## Prerequisites
* Ruby installed on your machine
* Docker and Docker Compose (used for the PostgreSQL database)

## Setup & Installation

### 1. Start the Database
This project uses Docker Compose to run the PostgreSQL database. Run the following command to start the database container in the background:
```bash
docker-compose up -d
```

### 2. Install Dependencies
Install the required Ruby gems:
```bash
bundle install
```

### 3. Database Setup
Create the database and run the migrations:
```bash
rails db:create
rails db:migrate
```

### 4. Run the Application
Start the Rails server:
```bash
rails server
```
The application will now be running at `http://localhost:3000`.

### Stopping the Database
When you are finished working, you can stop the Docker container by running:
```bash
docker-compose down
```

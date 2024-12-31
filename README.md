# Persogen
**A Rails API for Generating Mock Person Data**

A focused API service that generates realistic mock profiles for development and testing purposes. Built with Ruby on Rails and secured with JWT authentication.

---

## Quick Overview
- **Core Function:** Generate single or bulk realistic person profiles via API
- **Tech Stack:** Rails 7.1.3, Ruby 3.3.4, PostgreSQL
- **Security:** JWT-based authentication using Devise

---

## Features

### Profile Generation
- Generate single or multiple (up to 100) realistic person profiles
- Each profile includes personal, professional, and financial details
- Consistent data structure with proper formatting

Example Profile Structure:
```json
{
  "name": "Jane Smith",
  "email": "jane.smith@example.com",
  "address": {
    "street": "123 Main St",
    "city": "Springfield",
    "state": "Illinois",
    "country": "United States",
    "zip_code": "62701"
  },
  "phone": "+1 (555) 123-4567",
  "job": "Senior Developer",
  "company": {
    "name": "Tech Solutions Inc",
    "industry": "Information Technology"
  },
  "social_media": {
    "twitter": "@janesmith",
    "linkedin": "janesmith"
  },
  "date_of_birth": "1990-05-15",
  "credit_card": {
    "number": "4532123456789012",
    "expiry_date": "2026-03"
  }
}
```

### Security
- JWT-based authentication with Devise
- Strong password requirements (uppercase, lowercase, number, special character)
- Secure account management with email verification

### Developer Tools
- RESTful API endpoints
- Comprehensive test coverage
- Docker support
- CircleCI integration
---

## Installation

### Prerequisites

Before you begin, ensure you have the following installed:
- Ruby 3.3.4 or higher
- PostgreSQL 9.5 or higher
- Bundler gem

### Setup Guide

1. **Clone the Repository**
   ```bash
   git clone https://github.com/yourusername/persogen.git
   cd persogen
   ```

2. **Install Dependencies**
   ```bash
   # Install all required gems
   bundle install
   ```
3. **Set Up Database**
   ```bash
   # Create and setup the database
   rails db:create
   rails db:migrate
   ```

4. **Start the Server**
   ```bash
   # Start Rails server on default port 3000
   rails server
   ```

5. **Verify Installation**
   ```bash
   # The API should now be accessible at
   http://localhost:3000
   ```
---
## API Usage

### 1. Authentication Flow

First, you'll need to get your JWT token:

1. **Create an Account**
```bash
POST /signup
Content-Type: application/json

{
  "user": {
    "email": "user@example.com",
    "password": "SecurePass123!",
    "password_confirmation": "SecurePass123!",
    "first_name": "John",
    "last_name": "Doe"
  }
}
```

2. **Login to Get Your JWT Token**
```bash
POST /login
Content-Type: application/json

{
  "user": {
    "email": "user@example.com",
    "password": "SecurePass123!"
  }
}
```

Response:
```json
{
  "status": {
    "code": 200,
    "message": "User logged in successfully."
  },
  "data": {
    "id": 1,
    "email": "user@example.com",
    "first_name": "John",
    "last_name": "Doe"
  }
}
```

The JWT token will be in the response headers under `Authorization`. Use this token for all subsequent requests.

### 2. Using the API

Once you have your token, you can start generating profiles:

#### Generate Single Profile
```bash
GET /api/v1/person
Authorization: Bearer your_jwt_token_here
```

#### Generate Multiple Profiles
```bash
GET /api/v1/people?count=10
Authorization: Bearer your_jwt_token_here
```

Note: Keep your JWT token secure and include it in the `Authorization` header for all API requests.

---

## Testing

The project includes comprehensive RSpec tests:

```bash
bundle exec rspec
```

Test coverage includes:
- User model validations and password requirements
- Authentication flows
- Profile generation endpoints
- Bulk generation limits
- Error handling scenarios

---

## Development

### Docker Support
```bash
docker build -t persogen .
docker run -p 3000:3000 persogen
```

### CI Pipeline
- CircleCI integration
- Automated test suite execution
- Ruby version compatibility check
- Database migration verification

---

## Roadmap
Planned features:
- Customizable profile fields
- Export functionality (JSON/CSV)
- API documentation using OpenAPI/Swagger
- Rate limiting
- Caching layer

---

## License
MIT License
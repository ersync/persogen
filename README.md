# Persogen  

![Version](https://img.shields.io/badge/version-0.0.1-lightgreen)
[![CircleCI](https://dl.circleci.com/status-badge/img/circleci/8MamMcAVAVNWTcUqkjQk7R/PfirDRh5ea4LigCP4kC27B/tree/main.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/circleci/8MamMcAVAVNWTcUqkjQk7R/PfirDRh5ea4LigCP4kC27B/tree/main)
![Test Coverage: 100%](https://img.shields.io/badge/Test%20Coverage-100%25-brightgreen)
[![MIT License](https://img.shields.io/badge/license-MIT-brightgreen.svg)](https://opensource.org/licenses/MIT)

Persogen is a **Rails-based API** designed to help developers create realistic mock profiles for testing and development. It’s secure, straightforward, and tailored to make your workflow smoother.  

- **Purpose:** Quickly generate single or bulk person profiles for your projects  
- **Built With:** Rails 7.1.3, Ruby 3.3.4, PostgreSQL  
- **Security:** Robust JWT authentication, powered by Devise  

---

## Features  

- Generate up to 100 realistic profiles with personal, professional, and financial details.  
- Secure JWT authentication and account management with Devise.  
- RESTful API with consistent structure and comprehensive test coverage.  

---

## Getting Started  

### Requirements  

Before you start, make sure you have:  
- Ruby 3.3.4 or newer  
- PostgreSQL 9.5 or higher  
- Bundler gem  

### Installation  

1. **Clone the Repository**  
   ```bash  
   git clone https://github.com/yourusername/persogen.git  
   cd persogen  
   ```  

2. **Install Dependencies**  
   ```bash  
   bundle install  
   ```  

3. **Set Up the Database**  
   ```bash  
   rails db:create  
   rails db:migrate  
   ```  

4. **Start the Server**  
   ```bash  
   rails server  
   ```  

5. **Verify Installation**  

   Visit `http://localhost:3000` to confirm the API is up and running.  

---

## How to Use the API  

### 1. Authentication  

#### Create an Account  
Sign up to get started.  

```bash  
POST /signup  
Content-Type: application/json  

{
  "user": {
    "email": "user@example.com",
    "password": "SecurePass123!",
    "password_confirmation": "SecurePass123!"
  }
}
```  

#### Log In and Get Your JWT Token  
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

The token will be in the response headers under `Authorization`. You’ll need this token for all API requests.  

---

### 2. Profile Generation  

#### Generate a Single Profile  
```bash  
GET /api/v1/person  
Authorization: Bearer your_jwt_token_here  
```  

**Example Response:**  
```json  
{
  "data": [{
    "name": "Richard Stamm",
    "email": "edison.stiedemann@kutch.example",
    "address": {
      "street": "993 Earlene Radial",
      "city": "Pourosville",
      "state": "Mississippi",
      "country": "Guyana",
      "zip_code": "59029-1260"
    },
    "phone": "132-694-1497",
    "job": "Legacy Farming Technician",
    "company": {
      "name": "Kulas LLC",
      "industry": "Shipbuilding"
    },
    "social_media": {
      "twitter": "man_borerman_borer",
      "linkedin": "keneth.marvin"
    },
    "date_of_birth": "1966-06-10",
    "credit_card": {
      "number": "58194442128665567",
      "expiry_date": "2027-12-31"
    }
  }]
}
```  

#### Generate Multiple Profiles  
```bash  
GET /api/v1/people?count=10  
Authorization: Bearer your_jwt_token_here  
```  

💡 **Tip:** Keep your token secure and always include it in the `Authorization` header for API requests.  

---

## Testing  

We’ve included RSpec tests for reliability:  

```bash  
bundle exec rspec  
```  

**Tested Areas:**  
- User authentication  
- Profile generation endpoints  
- Error scenarios  

**Coverage & CI:**
- SimpleCov for test coverage tracking
- CircleCI for continuous integration

---

## Roadmap  


- Docker support  
- Customizable profile fields  
- Export profiles to JSON/CSV  
- Swagger-based API documentation  
- Rate limiting to handle heavy traffic  
- Caching for faster responses  

---

## License  

This project is available under the MIT License.  
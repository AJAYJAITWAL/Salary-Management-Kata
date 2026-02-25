# Employee Salary Management API

A production-ready RESTful API built using Ruby on Rails.

This project demonstrates clean architecture, strict Test-Driven Development (TDD), and thoughtful engineering decisions suitable for production systems.

---

## 🚀 Tech Stack

- Ruby 3.x
- Rails 8.x
- SQLite (development & test)
- RSpec (testing)

---

## 📌 Project Overview

This API manages employees and their salaries.

It includes:

- Employee CRUD operations
- Salary calculation endpoint
- Salary metrics endpoints
- Strict TDD workflow
- Clean separation of concerns

All records are persisted in a SQLite database.

---

# 🧩 Features Implemented

---

## 1️⃣ Employee CRUD

### Endpoints

Create Employee  
`POST /api/v1/employees`

List Employees  
`GET /api/v1/employees`

Show Employee  
`GET /api/v1/employees/:id`

Update Employee  
`PUT /api/v1/employees/:id`

Delete Employee  
`DELETE /api/v1/employees/:id`

---

### Employee Attributes

Each employee contains:

- full_name (required)
- job_title (required)
- country (required)
- salary (required, must be greater than 0)

Validations ensure data integrity.

---

## 2️⃣ Salary Calculation Endpoint

### Endpoint

GET /api/v1/employees/:id/salary

### Example Response

```json
{
  "gross": "100000.0",
  "tds": "10000.0",
  "net": "90000.0"
}
```

### Deduction Rules

India → 10% TDS  
United States → 12% TDS  
All other countries → No deductions  

Business logic is implemented using a Service Object:

```
app/services/payroll/salary_calculator.rb
```

This keeps controllers thin and business logic isolated.

---

## 3️⃣ Salary Metrics Endpoints

### A. Metrics by Country

Endpoint:

```
GET /api/v1/salary_metrics/country?country=India
```

Example Response:

```json
{
  "country": "India",
  "minimum": "80000.0",
  "maximum": "150000.0",
  "average": "110000.0"
}
```

---

### B. Metrics by Job Title

Endpoint:

```
GET /api/v1/salary_metrics/job_title?job_title=Developer
```

Example Response:

```json
{
  "job_title": "Developer",
  "average": "120000.0"
}
```

Metrics are implemented using a Query Object:

```
app/queries/salary_metrics_query.rb
```

This ensures efficient SQL aggregation (MIN, MAX, AVG) directly at the database level.

---

# 🧠 Architecture Overview

The application follows clean architecture principles:

| Layer | Responsibility |
|--------|---------------|
| Models | Data validation and persistence |
| Services | Business logic (salary calculations) |
| Queries | Read-only aggregation logic |
| Serializers | Output formatting |
| Controllers | HTTP orchestration |
| ApplicationController | Centralized error handling |

This separation improves maintainability, testability, and scalability.

---

# 🧪 Testing Strategy (Strict TDD)

This project follows a strict Test-Driven Development workflow:

1. Write a failing test (RED)
2. Implement minimal code to pass (GREEN)
3. Refactor safely (REFACTOR)

Commit history reflects this loop.

Test coverage includes:

- Model validations
- CRUD endpoints
- Salary calculation logic
- Salary metrics logic
- Edge cases
- Error handling

All tests are:

- Fast
- Deterministic
- Isolated
- Database-clean between runs

Run tests with:

```
bundle exec rspec
```

---

# ⚙️ Setup Instructions

### 1️⃣ Install Dependencies

```
bundle install
```

### 2️⃣ Setup Database

```
rails db:create
rails db:migrate
```

### 3️⃣ Run Server

```
rails server
```

# 📂 Folder Structure

```
app/
  controllers/
  models/
  services/
  queries/
  serializers/
spec/
```

---

# 🎯 Production Considerations

If extended further, this project could include:

- JWT Authentication
- Pagination
- Swagger / OpenAPI documentation
- Docker support
- CI/CD pipeline
- Background job processing
- Rate limiting
- Monitoring and logging improvements

---

# 🏁 Final Notes

This project demonstrates:

- Strong TDD discipline
- Clean code principles
- Thoughtful architectural decisions
- Production-ready API design

It reflects how real-world systems are designed, built, tested, and prepared for deployment.

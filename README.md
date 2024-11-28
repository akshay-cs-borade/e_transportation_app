```markdown
# E-Transportation Management System

The **E-Transportation Management System** is a scalable solution for managing and tracking various electronic transportation devices like e-Scooters and e-Bikes. This project includes an API for creating, retrieving, and grouping e-Transportation data, with support for both in-memory and database-backed storage.

---

## Features

- **Storage Mechanisms**:
  - In-Memory storage for lightweight and fast testing.
  - Database storage for persistence and scalability.

- **API Endpoints**:
  - Create new e-Transportations.
  - Retrieve all e-Transportations.
  - Group and retrieve e-Transportations outside a designated zone.

- **Validation**:
  - Ensures all attributes are present and valid.

- **Scalability**:
  - Easily switch between storage mechanisms using environment variables.

---

## Technologies Used

- **Ruby on Rails**: Backend framework for building APIs.
- **RSpec**: Test suite for ensuring high-quality code.
- **sqlite3**: Database used for persistent storage.
- **In-Memory Storage**: Fast, non-persistent storage for testing and lightweight applications.

---

## Setup and Installation

### Prerequisites

- Ruby (>= 3.0)
- Rails (>= 7.0)
- sqlite3
- Bundler (`gem install bundler`)

### Steps

1. Clone the repository:
   ```
   git clone https://github.com/your-username/e-transportation-system.git
   cd e-transportation-system
   ```

2. Install dependencies:
   ```
   bundle install
   ```

3. Set up the database:
   ```
   rails db:create db:migrate
   ```

4. Configure environment variables:
   - Create a `.env` file and add the following:
     ```env
     USE_IN_MEMORY=true # Set to 'false' to use the database
     ```

5. Run the application:
   ```
   rails server
   ```

6. Run the test suite:
   ```
   rspec
   ```

---

## API Endpoints

### Base URL
```
http://localhost:3000/api/v1/e_transportations
```

### Endpoints

1. **Create e-Transportation**
   - **POST** `/`
   - **Request Body**:
     ```json
     {
       "e_transportation": {
         "e_transportation_type": "e-Scooter",
         "sensor_type": "small",
         "owner_id": 1,
         "in_zone": true,
         "lost_sensor": false
       }
     }
     ```
   - **Response**:
     ```json
     {
       "message": "e-Transportation created successfully"
     }
     ```

2. **List All e-Transportations**
   - **GET** `/`
   - **Response**:
     ```json
     [
       {
         "e_transportation_type": "e-Scooter",
         "sensor_type": "small",
         "owner_id": 1,
         "in_zone": true,
         "lost_sensor": false
       }
     ]
     ```

3. **Grouped e-Transportations Outside the Zone**
   - **GET** `/outside_zone`
   - **Response**:
     ```json
     {
       "e-Bike - medium": 1
     }
     ```

---
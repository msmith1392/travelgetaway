# TravelGetaway

A full-stack, containerized trip planning app built with **React/Next.js**, **Java/Spring Boot**, and **MySQL**.

---

## Features

- Plan and manage multi-day trips with activities
- User authentication and secure data storage
- Responsive, modern UI
- RESTful API backend in Java with Spring Boot
- Persistent storage with MySQL
- Automated database migrations with Flyway

---

## Tech Stack

- **Frontend:** React, Next.js, TypeScript
- **Backend:** Java, Spring Boot, Spring Data JPA
- **Database:** MySQL
- **Containerization:** Docker Desktop

---

## Local Development Workflow

You can run services on your host machine for speed, or use Docker Compose for a consistent, isolated environment.

### Frontend (Host Machine)

Run locally with hot reload:

```bash
cd frontend
npm install
npm run dev
```

This is the fastest method for UI development and debugging.

### Backend (Host Machine)

Run the Spring Boot application directly from your IDE (like IntelliJ IDEA or VS Code) or using Maven:

```bash
cd backend
./mvnw spring-boot:run
```

This allows you to quickly test code changes with live reloading.

### Database (Docker)

It is highly recommended to use the Docker-managed MySQL container for both local development and integration testing. This keeps your environment consistent and avoids local MySQL setup complexities.

---

## Getting Started

### Prerequisites

- Docker Desktop
- Java 21+ & Maven 3.8+
- Node.js v20+

### Quick Start (Full Stack in Containers)

Clone the repository:

```bash
git clone <your-repo-url>
cd travelgetaway
```

Build and run with Docker Compose:

```bash
docker-compose up --build
```

This command will:

- Build the images for the frontend and backend
- Start containers for the frontend, backend, and MySQL database
- Create a persistent volume for MySQL data

---

## Service URLs

- **Frontend:** [http://localhost:3000](http://localhost:3000)
- **Backend API:** [http://localhost:8080](http://localhost:8080)
- **MySQL:** Exposed on port 3306

---

## Database Migrations

Database migrations are handled automatically by Flyway.  
When the Spring Boot application starts, Flyway checks for new SQL migration scripts in the `src/main/resources/db/migration` directory and applies them to the database.

Migration files must follow the naming convention:  
`V<VERSION>__<DESCRIPTION>.sql` (e.g., `V1__create_users_table.sql`).

---

## Project Structure

```
backend/    # Java/Spring Boot REST API
frontend/   # React/Next.js frontend application
docker/     # Dockerfiles for containerization
docker-compose.yml  # Defines services, networks, and volumes for Docker
```

---

## Environment Variables

Configuration is managed via a `.env` file in the root directory.  
See `.env.example` for a template.  
**Do not commit `.env` files containing secrets to version control.**

---

## Docker & Local Development

The `docker-compose.yml` file orchestrates all services for a seamless local development experience.

- **Start all services:**
  ```bash
  docker-compose up
  ```
- **Stop all services:**

  ```bash
  docker-compose down
  ```

  (Data in the MySQL volume persists across restarts.)

- **View logs:**
  ```bash
  docker-compose logs -f <service_name>
  # e.g., docker-compose logs -f backend
  ```

---

## Testing

- **Backend:** Uses [JUnit](https://junit.org/) for unit and integration tests.  
  Run backend tests with:

  ```bash
  cd backend
  ./mvnw test
  ```

- **Frontend:** Uses [Jest](https://jestjs.io/) (and React Testing Library) for unit and component tests.  
  Run frontend tests with:
  ```bash
  cd frontend
  npm test
  ```

Test coverage reports and configuration can be found in each respective project directory.

---

## Troubleshooting

- **Java Backend Docker Builds:**  
  Ensure your `pom.xml` is correctly configured and all dependencies are listed. The `Dockerfile.backend` expects a fat JAR to be created by the Maven build process.

- **Database Connection:**  
  Verify that the environment variables for the database connection (`DB_URL`, `DB_USER`, `DB_PASSWORD`) are correctly set in your `.env` file and are being passed to the backend container.

---

# TravelGetaway

A full-stack, containerized trip planning app built with React, Go, and Postgres.

---

## Features

- Plan and manage multi-day trips with activities
- User authentication and secure data storage
- Responsive, modern UI (Material UI)
- RESTful API backend in Go
- Persistent storage with PostgreSQL
- **Automated database migrations** with golang-migrate

---

## Tech Stack

- **Frontend:** React, TypeScript, Vite, Material UI
- **Backend:** Go (Golang), Gin, golang-migrate
- **Database:** PostgreSQL
- **Containerization:** Podman

---

## Local Development Workflow

For day-to-day development, use your host machine for speed and convenience:

- **Frontend:**  
  Run locally with hot reload:

  ```sh
  cd frontend
  npm install
  npm run dev
  ```

  This is fastest for UI development and debugging.

- **Backend:**  
  Run locally for rapid iteration:

  ```sh
  cd backend
  go run .
  ```

  This lets you quickly test code changes.

- **Database:**  
  It is recommended to use the Podman-managed Postgres container for both local development and integration testing.  
  This keeps your environment consistent and avoids local Postgres setup headaches.

Use **Podman containers** when you want to:

- Test integration between services
- Simulate production environments
- Verify container orchestration and environment variable handling

**Summary:**

- Use host machine for active frontend/backend development.
- Use Podman for database, integration/full stack testing, and deployment.

---

## Getting Started

### Prerequisites

- [Podman](https://podman.io/getting-started/installation)
- (Optional for development) Node.js v20+ and Go 1.24+

### Quick Start (Full Stack in Containers)

```sh
git clone https://github.com/msmith1392/travelgetaway.git
cd travelgetaway
podman machine init      # Only needed once (Windows/WSL2)
podman machine start     # Start Podman VM for each session
podman system connection list  # Verify connection is active
podman build -t travelgetaway-frontend -f docker/Dockerfile.frontend ./frontend
podman build -t travelgetaway-backend -f docker/Dockerfile.backend .
podman volume create travelgetaway_pgdata
./scripts/start-db-and-backend.sh
./scripts/start-frontend.sh
```

- Frontend: [http://localhost:3000](http://localhost:3000)
- Backend API: [http://localhost:8080](http://localhost:8080)
- Postgres: exposed on port 5432

---

### Development (Host Machine)

You can also run frontend and backend directly for fast local development:

#### Frontend

```sh
cd frontend
npm install
npm run dev
```

#### Backend

```sh
cd backend
go mod tidy
go run .
```

#### Database

- It is recommended to use the Podman-managed Postgres container for local development.
  This ensures consistency across environments, keeps your system clean, and makes setup and teardown easy.
  Your database setup (version, schema, configuration) will match production and CI
- **Migrations are automated**—no need to run migration scripts by hand.
- To seed demo data, run:
  ```sh
  psql -U $POSTGRES_USER -d $POSTGRES_DB -h localhost -p 5432 -f db/seed/001_seed_initial_data.sql
  ```
- **Alternatively, you can use [pgAdmin 4](https://www.pgadmin.org/) to connect to your database and run seed or custom SQL scripts interactively.**

---

## Project Structure

- See [ARCHITECTURE.md](./docs/ARCHITECTURE.md) for high-level design and API structure.
- See [DATABASE_SCHEMA_AND_USAGE_SCENARIO.md](./docs/DATABASE_SCHEMA_AND_USAGE_SCENARIO.md) for the full database schema, relationships, and collaboration workflow.

---

# Environment Variables

- See `.env.example` file for a configuration example.
- **Do not commit `.env` files with secrets.**

---

## Deployment

- The app is ready for deployment to any Podman-compatible platform.
- For production, set appropriate environment variables and secrets.

---

## Podman & Local Development

**Podman CLI and shell scripts orchestrate all services for a seamless local dev experience.**

- **Start all services:**

  ```sh
  ./scripts/start-db-and-backend.sh
  ./scripts/start-frontend.sh
  ```

- **Stop all services:**

  ```sh
  ./scripts/stop-all.sh
  ```

  (Data in the Postgres volume persists.)

**Notes:**

- Environment variables are managed via `.env.example` files in each service.
- You can run frontend and backend outside Podman if preferred (see above).
- You can use `start-db.sh` and `start-backend.sh` separately if needed.
- Logs for each service appear in your terminal when running the shell scripts.

---

## Database Migrations

- **Migrations are applied automatically** by the backend service at startup using golang-migrate.
- Migration files must use the `.up.sql` and `.down.sql` naming convention.
- The backend container reads migration files from `/app/db/migrations` and applies them on startup.
- No need to run migration scripts manually.

---

## Troubleshooting

### Go Backend Podman Builds

If you encounter errors during Podman builds for the backend such as:

- `COPY go.mod go.sum ./` fails: One or both files are missing.
- `RUN go build -o server main.go` fails: `main.go` is missing or not in the expected location.

**Solution:**

1. Make sure the following files exist in the `/backend` directory:

   - `main.go` — The entry point for your Go application.
   - `go.mod` and `go.sum` — Go module files for dependency management.
     (Learn more about Go modules [here](https://blog.golang.org/using-go-modules).)

2. If any are missing, run:

   ```sh
   cd backend
   go mod init github.com/msmith1392/travelgetaway
   go mod tidy
   ```

   This will generate `go.mod` and `go.sum`.  
   If you don’t have a `main.go`, create a minimal one as your entry point.

3. Ensure your `main.go` is in the `/backend` directory (not a subfolder) and named exactly `main.go`.

These files are required for Podman to build your Go backend image successfully.

---

## Automated Migrations & Seed Data

- **Migrations:**  
  When the backend container starts, it automatically applies all migrations found in `/app/db/migrations` using golang-migrate.
- **Seed Data:**  
  To populate demo data, run the seed SQL file manually using `psql` or `pgAdmin 4` (see above).

---

## References

- [golang-migrate documentation](https://github.com/golang-migrate/migrate)
- [Migration file naming conventions](https://github.com/golang-migrate/migrate/blob/master/MIGRATIONS.md)
- [Go API usage](https://pkg.go.dev/github.com/golang-migrate/migrate/v4)
- [pgAdmin 4](https://www.pgadmin.org/)

---

_TravelGetaway is a modern, full-stack reference project for React, Go, and Postgres with Podman-based deployment._

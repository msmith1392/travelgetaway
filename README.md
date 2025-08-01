# TravelGetaway

A full-stack, containerized trip planning app built with React, Go, and Postgres.

---

## Features

- Plan and manage multi-day trips with activities
- User authentication and secure data storage
- Responsive, modern UI (Material UI)
- RESTful API backend in Go
- Persistent storage with PostgreSQL
- Easy local development with Podman
- **Automated database migrations** with golang-migrate

---

## Tech Stack

- **Frontend:** React, TypeScript, Vite, Material UI
- **Backend:** Go (Golang), Gin, golang-migrate
- **Database:** PostgreSQL
- **Containerization:** Podman

---

## Getting Started

### Prerequisites

- [Podman](https://podman.io/getting-started/installation)
- (Optional for development) Node.js v20+ and Go 1.24+

### Quick Start

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

### Development (without Podman)

You can also run each service directly for local development:

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
go run main.go
```

#### Database

- Install Postgres locally or use Podman
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

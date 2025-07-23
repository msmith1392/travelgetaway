# TravelGetaway

A full-stack, containerized trip planning app built with React, Go, and Postgres.

---

## Features

- Plan and manage multi-day trips with activities
- User authentication and secure data storage
- Responsive, modern UI (Material UI)
- RESTful API backend in Go
- Persistent storage with PostgreSQL
- Easy local development with Docker Compose

---

## Tech Stack

- **Frontend:** React, TypeScript, Vite, Material UI
- **Backend:** Go (Golang), Gin
- **Database:** PostgreSQL
- **Containerization:** Docker, Docker Compose

---

## Getting Started

### Prerequisites

- [Docker](https://www.docker.com/) and [Docker Compose](https://docs.docker.com/compose/)
- (Optional for development) Node.js v20+ and Go 1.24+

### Quick Start (Recommended)

```sh
git clone https://github.com/msmith1392/travelgetaway.git
cd travelgetaway
docker-compose up --build
```

Running `docker-compose up --build` will start the frontend, backend, and database containers:

- Frontend: [http://localhost:3000](http://localhost:3000)
- Backend API: [http://localhost:8080](http://localhost:8080)
- Postgres: exposed on port 5432

---

### Development (without Docker)

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
go run main.go
```

#### Database

- Install Postgres locally or use Docker
- Run migration scripts in `/db/migrations/`

---

## Project Structure

See [ARCHITECTURE.md](./ARCHITECTURE.md) for details on folders, API, and design.

---

## Environment Variables

- See `.env.example` files in `frontend/` and `backend/` for configuration.

---

## Deployment

- The app is ready for deployment to any Docker-compatible platform.
- For production, set appropriate environment variables and secrets.

---

## Docker & Local Development

**Docker Compose** orchestrates all services for a seamless local dev experience.

- **Start all services:**

  ```sh
  docker-compose up --build
  ```

- **Restart all services:**

  ```sh
  docker-compose restart
  ```

- **Restart any service without affecting the others:**

  ```sh
  docker-compose restart frontend
  docker-compose restart backend
  docker-compose restart db
  ```

- **Stop all services:**

  ```sh
  docker-compose down
  ```

  (Data in the Postgres volume persists.)

**Notes:**

- Environment variables are managed via `.env.example` files in each service.
- You can run frontend and backend outside Docker if preferred (see above).
- Logs for each service appear in your terminal when running `docker-compose up`.

---

## Troubleshooting: Go Backend Docker Builds

If you encounter errors during Docker builds for the backend such as:

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

These files are required for Docker to build your Go backend image successfully.

---

_TravelGetaway is a modern, full-stack reference project for React, Go, and Postgres with Dockerized deployment._

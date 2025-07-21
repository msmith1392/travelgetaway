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
- (Optional for development) Node.js v18+ and Go 1.21+

### Quick Start (Recommended)

```sh
git clone https://github.com/msmith1392/travelgetaway.git
cd travelgetaway
docker-compose up --build
```

- Frontend: [http://localhost:3000](http://localhost:3000)
- Backend API: [http://localhost:8080](http://localhost:8080)
- Postgres: exposed on port 5432

### Development (without Docker)

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

_TravelGetaway is a modern, full-stack reference project for React, Go, and Postgres with Dockerized deployment._

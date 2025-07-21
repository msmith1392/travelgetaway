# TravelGetaway – Architecture & Implementation Guide

This document describes the architecture, design decisions, and technology stack for the TravelGetaway app.

---

## Overview

TravelGetaway is a full-stack web application for planning and managing multi-day trips.  
It features a React/TypeScript frontend, a Go backend API, a Postgres database, and is fully containerized with Docker.

---

## Project Structure

```
travelgetaway/
├── backend/
│   ├── .env.example
│   ├── db/
│   ├── handlers/
│   ├── models/
│   ├── go.mod
│   └── main.go
├── db/
│   ├── migrations/
│   └── seed/
├── frontend/
│   ├── .env.example
│   ├── eslint.config.js
│   ├── index.html
│   ├── package.json
│   ├── package-lock.json
│   ├── public/
│   ├── src/
│   ├── tsconfig.app.json
│   ├── tsconfig.json
│   ├── tsconfig.node.json
│   └── vite.config.ts
├── .gitignore
├── ARCHITECTURE.md
├── docker-compose.yml
├── Dockerfile.backend
├── Dockerfile.frontend
└── README.md
```

---

## Technology Stack

- **Frontend:** React, TypeScript, Vite, Material UI
- **Backend:** Go (Golang), net/http or Gin/Fiber/Echo (choose one)
- **Database:** PostgreSQL
- **Containerization:** Docker, Docker Compose

---

## Environment Configuration

- Both the `/backend` and `/frontend` directories include a `.env.example` file.
- These files document the required environment variables for each service (such as database URLs, API keys, and secrets).
- To configure your environment, copy `.env.example` to `.env` in each directory and fill in the appropriate values.
- **Note:** Never commit real `.env` files with secrets to version control.

---

## Type Definitions (Frontend Example)

```ts
// src/types/trip.ts
export interface ActivityDay {
  date: string; // ISO string, e.g., "2025-07-01"
  activities: string[];
}

export interface Trip {
  title: string;
  days: ActivityDay[];
}
```

## Data Models (Backend Example)

```go
// backend/models/trip.go
type ActivityDay struct {
    Date       string   `json:"date"` // ISO string, e.g., "2025-07-01"
    Activities []string `json:"activities"`
}

type Trip struct {
    Title string        `json:"title"`
    Days  []ActivityDay `json:"days"`
}
```

## Database Schema Example

```sql
-- db/migrations/001_create_tables.sql
CREATE TABLE trips (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL
);

CREATE TABLE activity_days (
    id SERIAL PRIMARY KEY,
    trip_id INTEGER REFERENCES trips(id),
    date DATE NOT NULL
);

CREATE TABLE activities (
    id SERIAL PRIMARY KEY,
    activity_day_id INTEGER REFERENCES activity_days(id),
    description TEXT NOT NULL
);
```

## Data Flow

1. **Frontend** communicates with the **Go API** via RESTful HTTP endpoints (JSON).
2. **Go API** handles business logic, authentication, and interacts with **Postgres** for data persistence.
3. **Docker Compose** orchestrates all services for local development and deployment.

---

## Key Components

### Frontend (`/frontend`)

- **Pages:** Home, Trip Planner, Trip Details, Not Found
- **Components:** TripForm, TripList, TripDetails, Login/Register, etc.
- **API Layer:** Handles requests to Go backend (using fetch/axios).
- **State Management:** React Context or Redux (if needed)
- **Styling:** Material UI

### Backend (`/backend`)

- **API Endpoints:** CRUD for trips, users, authentication
- **Models:** Trip, User, ActivityDay, etc.
- **Database Layer:** SQL queries or ORM (e.g., GORM)
- **Auth:** JWT or session-based authentication

### Database (`/db`)

- **Schema:** Users, Trips, Activities tables
- **Migrations:** SQL scripts for schema changes
- **Seed Data:** Optional demo data

---

## Example API Endpoints

- `POST /api/register` – Register a new user
- `POST /api/login` – Authenticate user

- `GET /api/trips` – List user’s trips
- `POST /api/trips` – Create a new trip

- `GET /api/trips/:id` – Get trip details
- `PUT /api/trips/:id` – Update trip
- `DELETE /api/trips/:id` – Delete trip

---

## Docker & Deployment

- **docker-compose.yml** spins up frontend, backend, and Postgres containers.
- **Dockerfile.backend** builds the Go API server.
- **Dockerfile.frontend** builds the React app.
- **Volumes** for persistent Postgres data.

---

## Design Goals

- Modern, type-safe, and maintainable codebase
- Clear separation of frontend and backend
- Secure authentication and data access
- Easy local development with Docker Compose
- Ready for cloud deployment (e.g., Render, Fly.io, AWS, etc.)

---

## Extensibility & Future Ideas

- OAuth login (Google, GitHub)
- Trip sharing/collaboration
- Mobile-friendly PWA
- Notifications/reminders
- Advanced search/filtering

---

_See [README.md](./README.md) for setup and usage instructions._

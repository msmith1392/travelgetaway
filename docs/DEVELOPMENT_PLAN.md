# Project Plan & Task Breakdown

This document outlines the major tasks and estimated effort for building TravelGetaway.  
It demonstrates the project’s structure, workflow, and time management.

> All container orchestration is done via Podman and shell scripts in the `scripts/` directory.  
> See [README.md](../README.md) for setup and usage.

---

## Frontend Tasks (Est. 30h)

- [ ] Scaffold React app in `/frontend` (Vite + TypeScript) — _1h_
- [ ] Set up Material UI and global theme — _2h_
- [ ] Implement routing (Home, Trip Planner, Trip Details, Not Found) — _2h_
- [ ] Build `TripForm` component (add/edit trip days/activities) — _4h_
- [ ] Build `TripList` and `TripDetails` components — _3h_
- [ ] Implement authentication UI (`login`/`register` forms) — _3h_
- [ ] Create API layer for backend communication using React Query — _2h_
- [ ] Manage state using Redux — _3h_
- [ ] Add form validation and error handling — _2h_
- [ ] Add responsive/mobile-friendly styles — _2h_
- [ ] Configure environment variables (`.env.example`) — _1h_
- [ ] Add unit/component tests — _3h_
- [ ] Polish UI/UX and accessibility — _2h_

---

## Backend Tasks (Est. 25h)

- [ ] Scaffold Go project in `/backend` (Gin) — _2h_
- [ ] Set up routing and middleware (CORS, logging, etc.) — _2h_
- [ ] Implement authentication (JWT/session) — _4h_
- [ ] Create models for `Trip`, `User`, `ActivityDay` — _2h_
- [ ] Implement CRUD endpoints for trips and activities — _4h_
- [ ] Implement user registration and login endpoints — _3h_
- [ ] Connect to Postgres database (env config) — _2h_
- [ ] Add input validation and error handling — _2h_
- [ ] Write integration tests — _3h_
- [ ] Configure environment variables (`.env.example`) — _1h_

---

## Database Tasks (Est. 7h)

- [x] Design schema for `users`, `trips`, `activity_days`, `activities`, `trip_users` — _2h_
- [x] Write migration scripts in `/db/migrations/` — _2h_
- [x] Add seed data scripts in `/db/seed/` — _1h_
- [x] Test migrations against local/dev Postgres — _1h_
- [x] Document schema in [DATABASE_SCHEMA_AND_USAGE_SCENARIO.md](./DATABASE_SCHEMA_AND_USAGE_SCENARIO.md) — _1h_

---

## Podman & DevOps Tasks (Est. 8h)

- [x] Write `Dockerfile.frontend` for React build and static serving — _1h_
- [x] Write `Dockerfile.backend` for Go API build and run — _1h_
- [x] Write shell scripts to orchestrate frontend, backend, and Postgres with Podman — _2h_
- [x] Configure volumes for Postgres data persistence — _1h_
- [x] Set up environment variable passing in shell scripts — _1h_
- [x] Test full stack with Podman CLI and scripts — _1h_
- [x] Document Podman usage in `README.md` — _1h_

---

**Total Estimated Effort:** ~70 hours

---

## Troubleshooting

### Go Backend Podman Builds

When building the backend Podman image, ensure the following files exist in `/backend`:

- `main.go` — The entry point for your Go application.
- `go.mod` and `go.sum` — Go module files for dependency management.

If missing, run:

```sh
cd backend
go mod init github.com/msmith1392/travelgetaway
go mod tidy
```

# Podman Setup and Usage Guide

## Basic Commands

```sh
podman pull <image>                        # Pull an image
podman build -t <name> -f <Dockerfile> <context>  # Build image
podman images                              # List images
podman run -d --name <name> ... <image>    # Run container
podman ps                                  # List running containers
podman ps -a                               # List all containers
podman stop <container>                    # Stop container
podman start <container>                   # Start container
podman rm <container>                      # Remove container
podman logs <container>                    # View container logs
podman exec -it <container> <cmd>          # Exec into container
podman volume create <name>                # Create volume
podman volume ls                           # List volumes
podman volume rm <name>                    # Remove volume
podman inspect <container|image>           # Inspect details
podman network ls                          # List networks
podman network create <name>               # Create network
```

## Common Options

- `-d` : Detached mode (run in background)
- `-p host:container` : Map ports
- `-e KEY=VALUE` : Set environment variable
- `-v host:container` : Mount volume
- `--name <name>` : Name the container

---

## Project Startup Workflow

1. **Initialize and Start Podman Machine (Windows/WSL2 only)**

   ```sh
   podman machine init      # Only needed once
   podman machine start     # Start Podman VM for each session
   podman system connection list  # Verify connection is active
   ```

2. **Build Images**

   ```sh
   podman build -t travelgetaway-frontend -f docker/Dockerfile.frontend ./frontend
   podman build -t travelgetaway-backend -f docker/Dockerfile.backend .
   ```

3. **Create Volumes**

   ```sh
   podman volume create travelgetaway_pgdata
   ```

4. **Make Startup Scripts Executable (first time only)**

   ```sh
   chmod +x ./scripts/*.sh
   ```

5. **Start Database and Backend Together**

   Use the combined script to start both containers in the correct order:

   ```sh
   ./scripts/start-db-and-backend.sh
   ```

   - This script will:

     - Start the Postgres container if it’s not running
     - Wait for the database to be ready
     - Start the backend container (which runs migrations on startup automatically)

   - **Migrations:**
     - Migration files must use the `.up.sql` and `.down.sql` naming convention and be located in `db/migrations/`.
     - Migrations are applied automatically by the backend service at startup using golang-migrate.
     - If migration files are not named correctly, migrations will fail with errors like `file does not exist`.
     - See [golang-migrate documentation](https://github.com/golang-migrate/migrate) and [Migration file naming conventions](https://github.com/golang-migrate/migrate/blob/master/MIGRATIONS.md) for details.
     - For Go API usage, see [pkg.go.dev](https://pkg.go.dev/github.com/golang-migrate/migrate/v4).

6. **Start Frontend Container**

   ```sh
   ./scripts/start-frontend.sh
   ```

---

## Individual Startup Scripts (Advanced Usage)

- **Start only the database:**

  ```sh
  ./scripts/start-db.sh
  ```

- **Start only the backend (after DB is running):**

  ```sh
  ./scripts/start-backend.sh
  ```

- **Start only the frontend:**
  ```sh
  ./scripts/start-frontend.sh
  ```

---

## Shutting Down Containers

**Stop all services:**

```sh
./scripts/stop-all.sh
```

**Stop a specific container:**

```sh
podman stop travelgetaway-db
podman stop travelgetaway-backend
podman stop travelgetaway-frontend
```

**Remove a specific container:**

```sh
podman rm travelgetaway-db
podman rm travelgetaway-backend
podman rm travelgetaway-frontend
```

**Stop all running containers:**

```sh
podman stop $(podman ps -q)
```

**Remove all stopped containers:**

```sh
podman rm $(podman ps -a -q)
```

---

## Notes

- Environment variables are loaded from the root `.env` file.
- The backend container will automatically run database migrations on startup using golang-migrate. No manual migration commands are needed.
- Migration files must use the `.up.sql` and `.down.sql` naming convention and are located in `db/migrations/`.
- To seed demo data, use `psql` or [pgAdmin 4](https://www.pgadmin.org/) to run the seed SQL script (`db/seed/001_seed_initial_data.sql`).
- For most workflows, use `start-db-and-backend.sh` and `start-frontend.sh` for convenience.
- You can use pgAdmin 4 for interactive database management and seeding.
- See [README.md](../README.md) for full setup and usage instructions.

---

## References

- [golang-migrate documentation](https://github.com/golang-migrate/migrate)
- [Migration file naming conventions](https://github.com/golang-migrate/migrate/blob/master/MIGRATIONS.md)
- [Go API usage](https://pkg.go.dev/github.com/golang-migrate/migrate/v4)
- [pgAdmin 4](https://www.pgadmin.org/)

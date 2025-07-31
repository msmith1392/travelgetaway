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
   podman build -t travelgetaway-backend -f docker/Dockerfile.backend ./backend
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
     - Start the backend container (which runs migrations on startup)

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

- Environment variables are loaded from `.env` files in the project root.
- The backend container will automatically run migrations on startup if implemented in your Go code.
- For most workflows, use `start-db-and-backend.sh` and `start-frontend.sh` for convenience.

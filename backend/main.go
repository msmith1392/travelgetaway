package main

import (
	"log"
	"net/http"
	"os"

	"github.com/gin-gonic/gin"
	"github.com/golang-migrate/migrate/v4"
	_ "github.com/golang-migrate/migrate/v4/database/postgres"
	_ "github.com/golang-migrate/migrate/v4/source/file"
)

func runMigrations(migrationsPath, databaseURL string) {
	m, err := migrate.New(
		migrationsPath,
		databaseURL,
	)
	if err != nil {
		log.Fatalf("Migration setup failed: %v", err)
	}
	if err := m.Up(); err != nil && err != migrate.ErrNoChange {
		log.Fatalf("Migration failed: %v", err)
	}
	log.Println("Database migrations applied successfully.")
}

func main() {
	loadEnvFile("../.env")

	dbURL := os.Getenv("DATABASE_URL")
	migrationsPath := os.Getenv("MIGRATIONS_PATH")

	if migrationsPath == "" {
		migrationsPath = "file:///app/db/migrations" // Default container path.
	}

	log.Printf("DATABASE_URL: %s", dbURL)
	log.Printf("MIGRATIONS_PATH: %s", migrationsPath)
	runMigrations(migrationsPath, dbURL)

	r := gin.Default()
	r.GET("/health", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{"status": "ok"})
	})

	// Add more routes here

	r.Run(":8080") // Listen and serve on port 8080
}

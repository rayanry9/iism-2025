package config

import (
	"context"
	"log/slog"
	"os"

	"path/filepath"

	"github.com/golang-migrate/migrate/v4"
	_ "github.com/golang-migrate/migrate/v4/database/postgres"
	_ "github.com/golang-migrate/migrate/v4/source/file"
	"github.com/jackc/pgx/v5/pgxpool"
)

var DB *pgxpool.Pool

func InitDB() {
	var err error
	DB, err = pgxpool.New(context.Background(), os.Getenv("DB_URL"))

	if err != nil {
		slog.Error("Failed to initialize DB")
		os.Exit(1)
	}

	if os.Getenv("GIN_MODE") == "release" {
		wd, err := os.Getwd()
		m, err := migrate.New(filepath.Join("file:///", wd, "internal/migrations"), os.Getenv("DB_URL"))
		if err != nil {
			slog.Error("Failed to Migrate")
			slog.Error(err.Error())
			os.Exit(1)
		}
		if err = m.Up(); err != nil && err != migrate.ErrNoChange {
			slog.Error("Failed to migrate UP")
			slog.Error(err.Error())
			os.Exit(1)
		}
		slog.Info("Migrated database UP")
	}

}

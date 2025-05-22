package config

import (
	"context"
	"log/slog"
	"os"

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
}

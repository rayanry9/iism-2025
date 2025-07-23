dev_migrate_down:
	@set -o allexport; . ./.env; set +o allexport;\
	migrate -database $$DB_URL -path internal/migrations down

dev_migrate_down_1:
	@set -o allexport; . ./.env;set +o allexport;\
	migrate -database $$DB_URL -path internal/migrations down 1

dev_migrate_up:
	@set -o allexport; . ./.env;set +o allexport;\
	migrate -database $$DB_URL -path internal/migrations up

dev_migrate_up_1:
	@set -o allexport; . ./.env;set +o allexport;\
	migrate -database $$DB_URL -path internal/migrations up 1

dev_migrate_drop:
	@set -o allexport; . ./.env;set +o allexport;\
	migrate -database $$DB_URL -path internal/migrations drop -f
	
migrate_down:
	@set -o allexport; . ./.env;set +o allexport;\
	migrate -database $$DB_URL -path internal/migrations down

migrate_up:
	@set -o allexport; . ./.env;set +o allexport;\
	migrate -database $$DB_URL -path internal/migrations up

migrate_drop:
	@set -o allexport; . ./.env;set +o allexport;\
	migrate -database $$DB_URL -path internal/migrations drop -f

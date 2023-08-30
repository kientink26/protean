# Include variables from the .envrc file
include .envrc

## run/api: run the cmd/api application
run/api:
	go run ./cmd/api \
	-port=${SERVER_PORT} \
	-db-dsn=${PROTEAN_DB_DSN}

## db/migrations/new name=$1: create a new database migration
db/migrations/new:
	@echo 'Creating migration files for ${name}...'
	migrate create -seq -ext=.sql -dir=./migrations ${name}

## db/migrations/up: apply all up database migrations
db/migrations/up:
	@echo 'Running up migrations...'
	migrate -path ./migrations -database ${PROTEAN_DB_DSN} up

## db/migrations/down: apply all down database migrations
db/migrations/down:
	@echo 'Running down migrations...'
	migrate -path ./migrations -database ${PROTEAN_DB_DSN} down

## db/migrations/goto: migrate up or down to a specific version
db/migrations/goto:
	@echo 'Go to version ${version}'
	migrate -path ./migrations -database ${PROTEAN_DB_DSN} goto ${version}

## db/migrations/force: force to a specific version
db/migrations/force:
	@echo 'Force to version ${version}'
	migrate -path ./migrations -database ${PROTEAN_DB_DSN} force ${version}
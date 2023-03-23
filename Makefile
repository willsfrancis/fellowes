.PHONY: help

help:
	@echo "Available commands:"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  make \033[36m%-14s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	@echo ""

install: ## Install packages using yarn ci/npm ci if package.json is in the project root, otherwise use yarn install
ifeq ($(OS),Windows_NT)
	install.bat
else
	./install.sh
endif

autoprefixer: ## Autoprefixer: Process the CSS file and add vendor prefixes for cross-browser support.
	find ./css -type f -iname "*.css" -exec ./node_modules/.bin/postcss -r {} \;

lint: ## Check & Fix code ESLint
	npx eslint --fix "src/**"

pretty: ## Formats code in assets/css, assets/js, and HTML files using Prettier
	npx prettier --write "src/{css,js}/**/*.{css,js}" "src/*.html"

format: pretty autoprefixer ## Prettier -> Autoprefixer

start: ## Start the server with an optional port (e.g., make serve PORT=4040)
	@echo "Starting server on port $(PORT)"
ifeq ($(PORT),)
	npx vite
else
	npx vite --host 0.0.0.0 --port $(PORT)
endif

build-prod: pretty lint ## Build PROD project
	vite build

build-dev: pretty lint ## Build DEV project
	npx vite build --mode development

preview: ## Preview project
	npx vite preview

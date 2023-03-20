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

serve: ## Start the server with an optional port (e.g., make serve PORT=4040)
	@echo "Starting server on port $(PORT)"
ifeq ($(PORT),)
	browser-sync start --server --files="**/*"
else
	browser-sync start --server --files="**/*" --port $(PORT)
endif

format: ## Formats code in assets/css, assets/js, and HTML files using Prettier
	npx prettier --write "assets/{css,js}/**/*.{css,js}" "*.html"

autoprefixer: ## Autoprefixer: Process the CSS file and add vendor prefixes for cross-browser support.
	find assets/css -type f -iname "*.css" -exec ./node_modules/.bin/postcss -r {} \;

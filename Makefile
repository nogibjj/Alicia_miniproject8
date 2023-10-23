# Variables
RUST_TARGET = target/release/Mini8

# Rust targets
rust-version:
	@echo "Rust command-line utility versions:"
	rustc --version 			# Rust compiler
	cargo --version 			# Rust package manager
	rustfmt --version			# Rust code formatter
	rustup --version			# Rust toolchain manager
	clippy-driver --version		# Rust linter

format:
	cargo fmt --quiet

install:
	# Install if needed
	#@echo "Updating rust toolchain"
	#rustup update stable
	#rustup default stable 

lint:
	cargo clippy --quiet

test:
	cargo test --quiet

run:
	cargo run

release:
	cargo build --release

# Python targets
py_install:
	python3 get-pip.py
	pip install --upgrade pip &&\
	pip install -r requirements.txt

py_test:
	python3 -m pytest -vv --cov=main test_*.py

py_format:	
	black *.py 

py_lint:
	ruff check *.py

py_container-lint:
	docker run --rm -i hadolint/hadolint < Dockerfile

py_deploy:
	# Python deploy commands go here

# Combined targets for convenience
all: format lint test run

py_all: py_install py_lint py_test py_format py_deploy

generate_and_push:
	# Add, commit, and push the generated files to GitHub
	@if [ -n "$$(git status --porcelain)" ]; then \
		git config --local user.email "action@github.com"; \
		git config --local user.name "GitHub Action"; \
		git add .; \
		git commit -m "Add metric log"; \
		git push; \
	else \
		echo "No changes to commit. Skipping commit and push."; \
	fi
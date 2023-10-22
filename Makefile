# Display Rust command-line utility versions
rust-version:
	@echo "Rust command-line utility versions:"
	rustc --version              # Rust compiler
	cargo --version              # Rust package manager
	rustfmt --version            # Rust code formatter
	rustup --version             # Rust toolchain manager
	clippy-driver --version      # Rust linter

# Format code using rustfmt
format:
	cargo fmt --quiet

# Run clippy for linting
lint:
	cargo clippy --quiet

# Run tests
test:
	cargo test --quiet

# Build and run the project
run:
	cargo run

# Build release version
release:
	cargo build --release

# Install Rust toolchain if needed
install:
	# Install if needed
	# @echo "Updating rust toolchain"
	# rustup update stable
	# rustup default stable 

# Run all formatting, linting, and testing tasks
all: format lint test run

# Custom tasks

# Example: Extract data
extract: 
	cargo run extract

# Example: Transform and Load data
transform_load:
	cargo run transform_load

# Example: Create a database entry
create:
	cargo run query "INSERT INTO gundataDB (intent, age, year, race, place, month, education) VALUES ('Suicide', 30, '2023', 'Asian/Pacific Islander', 'Home', 12, 'Some college');"

# Example: Read from the database
read:
	cargo run query "SELECT * FROM gundataDB WHERE intent = 'Suicide';"

# Example: Update a database entry
update:
	cargo run query "UPDATE gundataDB SET intent='Suicide', age=30, year='2023', race='White', place='Street', month=3, education='BA+' WHERE id=1;"

# Example: Delete a database entry
delete:
	cargo run query "DELETE FROM gundataDB WHERE id=3;"

# Generate and push changes to GitHub
generate_and_push:
	@if [ -n "$$(git status --porcelain)" ]; then \
		git config --local user.email "action@github.com"; \
		git config --local user.name "GitHub Action"; \
		git add .; \
		git commit -m "Add query log"; \
		git push; \
	else \
		echo "No changes to commit. Skipping commit and push."; \
	fi
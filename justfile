# askama_gettext — gettext for Askama templates

msrv := `sed -n 's/^rust-version = "\(.*\)"/\1/p' Cargo.toml`

# What CI checks: format, lint with warnings as errors, tests, docs, the MSRV.
check:
    cargo fmt --all -- --check
    cargo clippy --locked --all-targets -- -D warnings
    cargo test --locked
    RUSTDOCFLAGS="-D warnings" cargo doc --locked --no-deps
    cargo +{{msrv}} check --locked --all-targets
    python3 scripts/changelog.py --lint
    actionlint

# Format
fmt:
    cargo fmt --all

# Check Cargo.lock against RustSec advisories, with deny.toml's ignores
audit:
    cargo deny check advisories

# Install the git hooks
hooks:
    lefthook install

# Write CHANGELOG.md from the fragments in changelog.d/. `--stdout` prints it instead.
changelog *args:
    python3 scripts/changelog.py {{args}}

# Open the release PR: `just release patch|minor|major`, or an exact version.
# Merging it publishes the crate and the GitHub release; tags are never pushed by hand.
release version *args:
    scripts/release.sh {{version}} {{args}}

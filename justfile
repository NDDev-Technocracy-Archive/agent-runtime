# SPDX-License-Identifier: AGPL-3.0-only

set shell := ["bash", "-euo", "pipefail", "-c"]

# List the retained source-check commands.
default:
    @just --list

# Check workflow and command source without building or running the runtime.
check:
    just --fmt --check
    actionlint
    zizmor --offline --no-progress .github/workflows/ci.yml .github/workflows/security.yml .github/dependabot.yml

# Keep the complete committed-history scan on integration and manual full checks.
security:
    betterleaks git --redact --no-banner .

# Run the full retained source gate; native Go jobs remain separate.
verify: check security

# Format only the command source.
fix:
    just --fmt

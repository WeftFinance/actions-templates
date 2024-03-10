#!/bin/bash

generate_github_actions_yaml() {
    local package_name="$1"
    local directory="$2"

    cat <<EOF
name: Package CI - $package_name

on:
  push:
    branches:
      - main
    paths:
      - blueprints/$directory/tests/**
      - blueprints/$directory/src/**
  pull_request:
    branches:
      - main
      - dev
    paths:
      - blueprints/$directory/tests/**
      - blueprints/$directory/src/**

jobs:

  check-and-lint:
    if: github.event_name == 'pull_request'
    permissions:
      contents: write
      pull-requests: write
    uses: WeftFinance/actions-templates/.github/workflows/scrypto-package-check-and-lint.yaml@main
    with:
      package: blueprints/$directory
      scrypto_version: v1.1.1

  build-and-release:
    if: github.event_name == 'push' && github.ref == 'refs/heads/main'
    permissions:
      contents: write
      pull-requests: write
    uses: WeftFinance/actions-templates/.github/workflows/scrypto-package-build-and-release.yaml@main
    with:
      package: blueprints/$directory
      scrypto_version: v1.1.1
EOF
}

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <package_name> <directory>"
    exit 1
fi

generate_github_actions_yaml "$1" "$2" > "$2.yml"
echo "GitHub Actions YAML file generated for $1 in $2.yml"

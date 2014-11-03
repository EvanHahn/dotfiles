#!/usr/bin/env bash
set -e

packages=(
seti-ui

language-csharp
language-jade
language-svg
language-typescript
language-verilog
language-viml

linter
linter-coffeelint
linter-flake8
linter-jshint

sort-lines
git-plus
)

for package in "${packages[@]}"; do
   apm install "$package"
done

#!/usr/bin/env bash
set -e
set -u

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

editorconfig
)

for package in "${packages[@]}"; do
   apm install "$package"
done

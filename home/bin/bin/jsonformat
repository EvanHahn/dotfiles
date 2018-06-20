#!/usr/bin/env bash
set -e
set -u
set -o pipefail

if hash node 2>/dev/null; then
  node -e '
  process.stdin.setEncoding("utf8")

  let jsonString = ""

  process.stdin.on("readable", () => {
    const chunk = process.stdin.read()
    if (chunk) {
      jsonString += chunk
    }
  })

  process.stdin.on("end", () => {
    console.log(
      require("util").inspect(
        JSON.parse(jsonString.trim()),
        {
          depth: 100,
          colors: true
        }
      )
    )
  })
  '
elif hash jq 2>/dev/null; then
  jq
else
  cat
fi

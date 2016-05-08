#!/usr/bin/env bash
set -e
set -u
set -o pipefail

output_path="$HOME/.css/github.com.css"

cloned_path='/tmp/github-dark'
if [[ -d "$cloned_path" ]]; then
  cd "$cloned_path"
  git checkout -f
  git pull
else
  git clone --depth 1 'https://github.com/StylishThemes/GitHub-Dark.git' "$cloned_path"
  cd "$cloned_path"
fi

npm install
npm install grunt-cli

cat > build.json << EOF
{
  "theme": "ambiance",
  "color": "#c9e6f2",
  "font": "not-going-to-override-this",
  "image": "none",
  "tiled": false,
  "codeWrap": true,
  "attach": "scroll",
  "tab": 2,
  "webkit": false
}
EOF

rm -rf ./*.build.css

"$(npm bin)/grunt"

cat > "$output_path" << EOF
@-moz-document url-prefix(https://github.com/explore) {
  #explore-featured {
    display: none;
  }

  .pagehead.explore-head {
    margin-bottom: 0;
  }
}
EOF

cat ./*.build.css >> "$output_path"

echo
echo 'we did it'

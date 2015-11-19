#!/usr/bin/env bash
set -e
set -u

output_path="$HOME/.css/github.com.css"

cloned_path='/tmp/github-dark'
if ! [[ -d "$cloned_path" ]]; then
  git clone 'https://github.com/StylishThemes/GitHub-Dark.git' "$cloned_path"
fi
cd "$cloned_path"

# npm install
# npm install grunt-cli

cat > build.json << EOF
{
  "theme": "ambiance",
  "color": "#F92672",
  "font": "FiraMono,Inconsolata,Consolas,Monaco,monospace",
  "image": "none",
  "tiled": false,
  "attach": "scroll",
  "tab": 4,
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

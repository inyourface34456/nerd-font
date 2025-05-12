#!/bin/bash


# Base URL for font files
base_url="https://raw.githubusercontent.com/inyourface34456/nerd-font/main/fonts"

# Start with a clean file

# Check for any matching files
shopt -s nullglob  # prevents literal pattern if no match
woff_files=(*.woff2)

if [ ${#woff_files[@]} -eq 0 ]; then
  echo "No .woff2 files found."
  exit 1
fi

# Loop through all .woff2 files
for file in "${woff_files[@]}"; do
  # Output CSS file
  output="../css/${file%.woff2}.css"
  
  # Strip the extension to get the font-family name
  font_name="${file%.woff2}"

  # Write the @font-face rule
  > "$output"
  cat >> "$output" <<EOF
@font-face {
    font-family: "${font_name}";
    src: url("${base_url}/${file}") format("woff2");
    font-weight: normal;
    font-style: normal;
    font-display: swap;
}

body {
    font-family: "${font_name}";
    font-size: 15px;
}
EOF
done

echo "CSS stylesheet generated in $output"

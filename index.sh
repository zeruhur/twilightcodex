#!/bin/bash

# Script to generate a markdown list of .md files in subfolders.

output_file="markdown_list.md" # Define the output file name

find . -type f -name "*.md" | while IFS= read -r file; do
  relative_path="${file#./}" # Remove "./" from the beginning
  filename=$(basename "$file")
  folder=$(dirname "$relative_path")

  if [[ "$folder" == "." ]]; then
      folder=""
  else
      folder="/$folder"
  fi

  echo " - [${filename%.md}](${folder}/${filename})" >> "$output_file"
done

if [[ -s "$output_file" ]]; then
  echo "Markdown list generated in '$output_file'."
else
  echo "No .md files found in the current directory or its subdirectories."
  rm -f "$output_file" # Remove empty output file
fi
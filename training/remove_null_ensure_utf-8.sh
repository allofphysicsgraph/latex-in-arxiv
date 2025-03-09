#!/bin/bash

# Script to pre-process a text file for UTF-8 compliance and null character removal.

# Input file (modify if needed)
INPUT_FILE="latex_data.txt"

# Output file (modify if needed) - It's good practice to create a new file
OUTPUT_FILE="latex_data_utf8_cleaned.txt"

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Check if required tools are installed
if ! command_exists iconv; then
  echo "Error: iconv is required. Please install it (e.g., sudo apt-get install iconv)."
  exit 1
fi

if ! command_exists sed; then
  echo "Error: sed is required. Please install it (usually pre-installed)."
  exit 1
fi

echo "Starting UTF-8 and null character cleanup..."

# 1. Remove null characters
echo "Removing null characters..."
sed -i 's/\x00//g' "$INPUT_FILE"

# 2. Convert to UTF-8 and remove invalid characters
echo "Converting to UTF-8 and removing non-UTF-8 characters..."
iconv -f UTF-8 -t UTF-8 -c "$INPUT_FILE" -o "$OUTPUT_FILE"

# 3. Replace the original with the cleaned version
#    Consider keeping the original as a backup for safety
# Commenting this part out for safety. uncomment when sure the processing is correct.
# mv "$OUTPUT_FILE" "$INPUT_FILE"

echo "UTF-8 and null character cleanup complete."
echo "Cleaned file saved to: $OUTPUT_FILE"
exit 0

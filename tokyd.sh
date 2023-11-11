#!/bin/bash

# URL template
BASE_URL="https://files02.tokybook.com/audio/the-quarry-girls/1673426834048/01_-_the_quarry_girls_a_thriller.mp3"

# Output file
OUTPUT_FILE="output.mp3"

# Create an empty file to store the list of downloaded files
echo -n > input.txt

# Function to download a file and append its name to input.txt
download_file() {
    index=$1
    url="${BASE_URL%/*}/$(printf "%02d" $index)${BASE_URL##*/}"
    wget "$url" && echo "file '$(printf "%02d" $index)${BASE_URL##*/}'" >> input.txt
}

# Loop to download files one by one
for i in {1..73}; do
    download_file $i
done

# Use ffmpeg to concatenate the downloaded files
ffmpeg -f concat -safe 0 -i input.txt -c copy "$OUTPUT_FILE"

# Clean up: remove the input.txt file
rm input.txt

echo "Download and concatenation complete. Output file: $OUTPUT_FILE"

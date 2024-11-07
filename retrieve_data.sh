#!/bin/bash

# Set paths
params_file="params.yml"
data_file="datahub/data.json"
temp_data_file="datahub/temp_data.json"

# Ensure datahub directory exists
mkdir -p datahub

# Read version and size from params.yml
version=$(yq e '.version' "$params_file")
size=$(yq e ".size.\"$version\"" "$params_file")

# Error handling for missing version or size
if [[ -z "$version" ]]; then
    echo "Error: Failed to retrieve 'version' from params.yml"
    exit 1
fi

if [[ -z "$size" ]]; then
    echo "Error: No size found for version $version in params.yml"
    exit 1
fi

echo "Retrieved size for version $version is: $size"

# Fetch data from API and limit results to the specified size
curl -s "https://jsonplaceholder.typicode.com/photos" | jq ".[:$size]" > "$temp_data_file"

# Check if data.json already exists
if [[ -f "$data_file" ]]; then
    # Compare the new data with the existing data
    if cmp -s "$temp_data_file" "$data_file"; then
        echo "No changes; data has not changed"
        rm "$temp_data_file"  # Clean up temporary file
        exit 0
    else
        echo "Data is different"
        mv "$temp_data_file" "$data_file"  # Update data.json with new data
        echo "Updated data.json with new data"
    fi
else
    echo "No existing data file found. Creating new data.json"
    mv "$temp_data_file" "$data_file"  # Move temp data to data.json
    echo "Created new data.json file"
fi

# Verify current version and size after operation
echo "The current data version is $version"
echo "The data size for version $version is $size"

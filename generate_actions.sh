#!/bin/bash

# Check if both package name and directory are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <package_name> <directory>"
    exit 1
fi

PACKAGE_NAME="$1"
DIRECTORY="$2"

# Download generate_actions.sh from weftfinance/actions-templates repository
curl -o generate_actions_template.sh https://raw.githubusercontent.com/weftfinance/actions-templates/main/generate_actions_template.sh

# Make the script executable
chmod +x generate_actions_template.sh

# Execute the script with the specified package name and directory
./generate_actions_template.sh "$PACKAGE_NAME" "$DIRECTORY"

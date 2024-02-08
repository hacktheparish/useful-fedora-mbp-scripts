#!/bin/bash

# Define an associative array of alias commands
declare -A alias_commands=(
    ["please"]="sudo"
    ["ll"]="ls -halF"
    ["turnscreen"]="$HOME/.mbp-scripts/turnscreen.sh"
    # Add more aliases here as needed
)

# Loop through the array and append each alias command to the ~/.bashrc file
for alias_name in "${!alias_commands[@]}"; do
    command="${alias_commands[$alias_name]}"
    alias_command="alias $alias_name='$command'"
    # Check if the alias already exists in the ~/.bashrc file
    if grep -q "$alias_command" ~/.bashrc; then
        echo "Alias $alias_name already exists in ~/.bashrc."
    else
        # Append the alias command to the ~/.bashrc file
        echo "$alias_command" >> ~/.bashrc
        echo "Alias $alias_name added to ~/.bashrc."
    fi
done


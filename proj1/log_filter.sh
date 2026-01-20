#! /bin/bash
set -euo pipefail

# Print usage instructions
function usage() {
    echo "Usage: $0 <log_file>"
    exit 1
}

if (( $# < 1 )); then
    usage
fi

log_file="$1"

# Output file
output_file="errors.log"

# Function to filter log lines
function filter_errors() {
    grep -Ei "error|fail" "$log_file" > "$output_file"
    echo "Filtered errors saved to $output_file"
}

if [[ -f "$log_file" ]]; then
    filter_errors
else
    echo "File not found: $log_file"
    exit 2
fi


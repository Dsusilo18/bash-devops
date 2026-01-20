#! /bin/bash
set -euo pipefail

#log_file="${1:-logs/app.log}"
log_file="logs/app.log"
timestamp="$(date +%Y%m%d_%H%M%S)"
backup_dir="backups"
sanitized_file="logs/sanitized_$timestamp.log"

# Check for flag
dry_run=false

for arg in "$@"
do
    if [[ "$arg" == "--dry-run" ]]
    then
        dry_run=true
    elif [[ -f "$arg" ]]
    then
        log_file="$arg"
    fi
done

# Checks if log file is older than 24 hours.
if [[ -f "$log_file" ]]
then
    if [[ "$(find "$log_file" -mmin +1440)" ]]
    then
        echo "Warning: $log_file is older than 24 hours!"
    fi
else
    echo "File not found: $log_file"
    exit 1
fi

if [[ $dry_run == false ]]
then
    # Make backup copy of the log file.
    mkdir -p "$backup_dir"
    cp "$log_file" "$backup_dir/app_$timestamp.log"

    # Remove Ip Addresses and Usernames from log files. 
    sed -E 's/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/[REDACTED_IP]/g' "$log_file" |
    sed -E 's/User [a-zA-Z0-9_]+/User [REDACTED_USER]/g' |
    sed 's/ERROR/issue/g' > "$sanitized_file"

    # Normalize the output by making it lowercase.
    tr '[:upper:]' '[:lower:]' < "$sanitized_file" > "${sanitized_file%.log}_lower.log"

    echo "Sanitized log saved to: ${sanitized_file%.log}_lower.log"
else
    echo "Dry run mode: Output will not be saved"
    sed -E 's/[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/[REDACTED_IP]/g' "$log_file" |
    sed -E 's/User [a-zA-Z0-9_]+/User [REDACTED_USER]/g' |
    sed 's/ERROR/issue/g' |
    tr '[:upper:]' '[:lower:]'
fi
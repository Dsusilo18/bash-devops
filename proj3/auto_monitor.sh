#! /bin/bash
set -euo pipefail

log_file="logs/app.log"
alert_dir="alerts"
timestamp="$(date +%Y%m%d_%H%M%S)"
alert_file="$alert_dir/alert_$timestamp.log"

mkdir -p "$alert_dir"

echo "Watching for changes in $log_file.."

run_once=false

[[ "${1:-}" == "--once" ]] && run_once=true

if $run_once
then
    # Using inotifywait to check for updates and reads the output of inotifywait just once.
    inotifywait -e modify "$log_file"

    # Run log_filter.sh and append output
    ../proj1/log_filter.sh "$log_file" >> "$alert_file"
    echo "One-time Alert logged at $alert_file"
else
    # Using inotifywait to check for updates and reads the output of inotifywait line by line.
    inotifywait -m -e modify "$log_file" | while read -r path event file
    do echo "Change detected: $event on $file"

        # Run log_filter.sh and append output
        ../proj1/log_filter.sh "$log_file" >> "$alert_file"

        echo "Alert logged at $alert_file"
    done
fi


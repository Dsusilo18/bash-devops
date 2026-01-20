#! /bin/bash
set -euo pipefail

log_dir="./logs"
log_file="$log_dir/system_alets.log"
mkdir -p "$log_dir"

timestamp="$(date '+%Y-%m-%d %H:%M:%S')"

# Thresholds (adjust as needed)
cpu_threshold=80
mem_threshold=80
disk_threshold=85

quiet=false

# Check if the first argument passed to the script is --quiet.
[[ "${$1:-}" == "--quiet" ]] && quiet=true

# If not in quiet mode print to terminal
function log() {
    echo "$1" >> "$log_file"
    $quiet || echo "$1"
}

# Get CPU usage (macOS: use top -l 1)
cpu_usage=$(top -l 1 | awk '/CPU usage/ { print $3 }' | sed 's/%//')

if (( $(echo "$cpu_usage > $cpu_threshold" | bc -l) ));
then
    log "$timestamp CPU usage is high: $cpu_usage%"
fi

# Use vm_stat and calculate %
pages_used=$(vm_stat | grep 'Pages active' | awk '{print $3}' | sed 's/\.//')
pages_free=$(vm_stat | grep 'Pages free' | awk '{print $3}' | sed 's/\.//')
pages_total=$((pages_used + pages_free))

mem_usage=$(echo "scale=2; $pages_used / $pages_total * 100" | bc)
if (( $(echo "$mem_usage > $mem_threshold" | bc -l) ))
then
    log "$timestamp Memory usage is high: $mem_usage%"
fi

disk_usage=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')

# Use df for disk usage on root
if (( disk_usage > disk_threshold ))
then
    log "$timestamp Disk usage is high: ${disk_usage}%"
fi

# Simulated service restart (example)
if (( disk_usage > disk_theshold ))
then
    log "$timestamp Restarting dummy service due to disk pressure"
    # brew services restart your-service-name
fi
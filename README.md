# Bash DevOps Automation Projects

A collection of hands-on Bash scripting projects focused on practical DevOps and system administration tasks including log analysis, data sanitization, file monitoring, alerting, and system resource monitoring.

These projects were built to strengthen my Bash/Linux automation skills by solving tasks similar to those encountered when supporting and monitoring infrastructure.

## Skills Practiced

- Bash scripting and shell automation
- Log parsing and filtering
- Regular expressions with `grep` and `sed`
- File and directory validation
- Command-line argument handling
- Functions and conditional logic
- Exit codes and error handling
- Strict Bash execution with `set -euo pipefail`
- Pipes and output redirection
- Timestamped logs and backups
- Data sanitization and redaction
- File-system event monitoring with `inotifywait`
- Reusing scripts from other automation scripts
- CPU, memory, and disk monitoring
- Text processing with `awk`, `sed`, `grep`, and `tr`
- Numeric comparisons with `bc`
- macOS command-line system monitoring

---

## Projects

### Project 1 — Log Error Filter

**Script:** [`proj1/log_filter.sh`](./proj1/log_filter.sh)

A Bash utility that accepts a log file as an argument, verifies that the file exists, and searches it for error-related entries.

The script:

- Accepts a log file from the command line
- Validates that the required argument was supplied
- Checks whether the requested file exists
- Uses case-insensitive `grep` matching for `error` and `fail`
- Writes matching entries to `errors.log`
- Uses functions and exit codes for cleaner script organization
- Uses `set -euo pipefail` for safer Bash execution

Example:

```bash
./log_filter.sh sample.log
```

This project introduced basic Bash automation for troubleshooting and log analysis.

---

### Project 2 — Log Sanitizer & Backup Automation

**Script:** [`proj2/log_sanitizer.sh`](./proj2/log_sanitizer.sh)

A more advanced log-processing script designed to protect sensitive information before logs are stored or shared.

The script:

- Accepts a custom log file
- Checks whether the log exists
- Detects logs older than 24 hours
- Creates timestamped backups before modifying data
- Redacts IPv4 addresses
- Redacts usernames
- Replaces selected error terminology
- Normalizes output to lowercase
- Creates timestamped sanitized log files
- Supports a `--dry-run` mode to preview changes without creating files

Example:

```bash
./log_sanitizer.sh logs/app.log
```

Dry-run mode:

```bash
./log_sanitizer.sh logs/app.log --dry-run
```

This project demonstrates safer log handling, backups, text transformation, argument processing, and non-destructive testing.

---

### Project 3 — Automated Log Monitor & Alerting

**Script:** [`proj3/auto_monitor.sh`](./proj3/auto_monitor.sh)

An event-driven monitoring script that watches a log file for changes and automatically triggers log analysis when an update occurs.

The project uses Linux `inotifywait` to respond to file-system events instead of continuously polling the file.

The script:

- Watches an application log for modifications
- Uses `inotifywait` for event-driven monitoring
- Supports continuous monitoring mode
- Supports a one-time `--once` mode
- Detects changes as they occur
- Calls the Project 1 log-filtering script automatically
- Stores monitoring activity in timestamped alert files
- Uses loops, command-line arguments, script chaining, and output redirection

Continuous monitoring:

```bash
./auto_monitor.sh
```

One-time monitoring:

```bash
./auto_monitor.sh --once
```

This project demonstrates how smaller automation scripts can be combined into a larger monitoring workflow.

---

### Project 4 — System Resource Monitor

**Script:** [`proj4/syswatch.sh`](./proj4/syswatch.sh)

A system-monitoring Bash script that collects resource information and generates alerts when configured thresholds are exceeded.

The script monitors:

- CPU usage
- Memory usage
- Disk usage

Default thresholds:

```text
CPU:    80%
Memory: 80%
Disk:   85%
```

The script uses several Unix command-line utilities together:

```text
top
vm_stat
df
awk
sed
grep
tail
bc
```

System information is parsed and converted into values that can be compared against configured thresholds. When usage becomes too high, an alert is written to a log file.

This project also explores the concept of automatically responding to unhealthy system conditions, such as triggering a service restart when resource pressure exceeds a threshold.

> This version was written around macOS system utilities such as `top -l 1` and `vm_stat`. Linux resource-monitoring commands differ slightly.

---

## Project Progression

The projects intentionally increase in complexity:

```text
Project 1
Log Filtering
     ↓
Project 2
Log Sanitization + Backups
     ↓
Project 3
Real-Time Monitoring + Script Integration
     ↓
Project 4
System Resource Monitoring + Alerting
```

Rather than treating Bash as only a command-line language, these projects focus on using it as an operations and infrastructure automation tool.

---

## Bash Concepts Used

Examples of Bash and Unix concepts practiced throughout the repository include:

```bash
grep
sed
awk
tr
find
cp
mkdir
date
df
top
vm_stat
bc
inotifywait
```

Along with:

```text
Variables
Functions
Conditionals
Loops
Command-line arguments
Exit codes
Pipes
Input/output redirection
Regular expressions
Command substitution
File tests
Boolean operators
Script-to-script execution
```

---

## Repository Structure

```text
bash-devops/
│
├── proj1/
│   ├── log_filter.sh
│   ├── sample.log
│   ├── errors.log
│   ├── notes.log
│   └── README.md
│
├── proj2/
│   ├── log_sanitizer.sh
│   ├── logs/
│   ├── backups/
│   ├── notes.log
│   └── README.md
│
├── proj3/
│   ├── auto_monitor.sh
│   ├── logs/
│   └── notes.log
│
└── proj4/
    ├── syswatch.sh
    └── notes.log
```

---

## Purpose

The goal of this repository is to build practical Bash automation experience relevant to:

- DevOps Engineering
- Systems Administration
- Infrastructure Support
- Technical Support Engineering
- Site Reliability / Operations

The projects focus on automating repetitive operational tasks, extracting useful information from logs and system commands, detecting problems, and building reusable scripts that can be incorporated into larger infrastructure workflows.

## Author

**Daryl Susilo**

GitHub: [Dsusilo18](https://github.com/Dsusilo18)

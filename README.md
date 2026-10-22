# Linux Server Health Monitor

A Bash-based tool for checking basic Linux system health and network connectivity.

## Features

- Displays hostname and system uptime
- Checks available memory
- Monitors disk usage
- Displays network interfaces
- Tests DNS resolution
- Checks internet connectivity
- Generates warnings when disk usage is high or available memory is low
- Saves timestamped monitoring reports automatically
- Displays an overall system health summary

## Technologies

- Linux
- Bash Scripting
- Linux command-line tools
- Git and GitHub

## Requirements

- Linux environment (Ubuntu or Ubuntu on WSL)
- Bash
- `free`, `df`, `ip`, `getent`, `awk`, and `curl`

## Usage

Make the script executable:

```bash
chmod +x monitor.sh
```

Run the monitor:

```bash
./monitor.sh
```

The results are displayed in the terminal and saved automatically in the `reports/` directory.

## Project Goal

This project demonstrates practical skills in Linux system administration, Bash scripting, system resource monitoring, and basic network diagnostics.

## Note

The script performs checks when executed manually. It does not provide continuous background monitoring.

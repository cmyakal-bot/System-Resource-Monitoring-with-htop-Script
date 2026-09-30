# System Resource Monitoring with top + Bash

## Objective
Monitor Linux CPU, memory, and process activity every 30 seconds for 10 minutes, persist the observations in a text log, and analyze the collected data to identify CPU-intensive processes.

## Files
- `monitor.sh` — collection script; 20 samples at 30-second intervals.
- `analyze.sh` — extracts and sorts process CPU observations.
- `log_to_csv.sh` — optional conversion of the log into CSV.
- `system_monitor.log` — demonstration log. Replace it with a real run before submitting lab evidence.

## Requirements
- Linux
- Bash
- `top`
- `awk`
- `grep`
- `sort`
- `head`
- `free`
- `uptime`

## Run
```bash
chmod +x monitor.sh analyze.sh log_to_csv.sh
./monitor.sh system_monitor.log
./analyze.sh system_monitor.log
./log_to_csv.sh system_monitor.log process_metrics.csv
```

## Design
The collector performs 20 samples because 10 minutes / 30 seconds = 20 intervals. `top -b -n 1` runs non-interactively, allowing its output to be redirected into a log. `awk` parses process rows and `sort` orders CPU observations numerically.

## Important
The included `.log` file is explicitly demonstration data. For a genuine POC submission, execute `monitor.sh` on the target Linux system and retain the resulting log and screenshots from that environment.

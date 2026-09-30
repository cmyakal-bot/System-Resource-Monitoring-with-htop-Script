#!/bin/bash
# System Resource Monitoring POC
# Collects CPU, memory, and top processes every 30 seconds for 10 minutes.

set -u

LOG_FILE="${1:-system_monitor.log}"
INTERVAL=30
SAMPLES=20

echo "============================================================" >> "$LOG_FILE"
echo "System Resource Monitoring POC" >> "$LOG_FILE"
echo "Start Time : $(date '+%Y-%m-%d %H:%M:%S %Z')" >> "$LOG_FILE"
echo "Interval   : ${INTERVAL} seconds" >> "$LOG_FILE"
echo "Samples    : ${SAMPLES}" >> "$LOG_FILE"
echo "============================================================" >> "$LOG_FILE"

for ((sample=1; sample<=SAMPLES; sample++)); do
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S %Z')

    {
        echo
        echo "################ SAMPLE ${sample}/${SAMPLES} ################"
        echo "Timestamp: ${TIMESTAMP}"
        echo "[SYSTEM]"
        uptime
        echo
        echo "[MEMORY]"
        free -h
        echo
        echo "[CPU / TOP PROCESSES]"
        printf "%-8s %-10s %-10s %-10s %-10s %s\n" "PID" "USER" "CPU%" "MEM%" "STAT" "COMMAND"
        top -b -n 1 -o %CPU | awk '
            NR > 7 && $1 ~ /^[0-9]+$/ {
                printf "%-8s %-10s %-10s %-10s %-10s ", $1, $2, $9, $10, $8;
                for (i=12; i<=NF; i++) printf "%s%s", $i, (i<NF ? OFS : ORS);
                count++;
                if (count >= 10) exit
            }'
    } >> "$LOG_FILE"

    if (( sample < SAMPLES )); then
        sleep "$INTERVAL"
    fi
done

{
    echo
    echo "============================================================"
    echo "Monitoring Completed"
    echo "End Time   : $(date '+%Y-%m-%d %H:%M:%S %Z')"
    echo "============================================================"
} >> "$LOG_FILE"

echo "Monitoring complete. Log written to: $LOG_FILE"

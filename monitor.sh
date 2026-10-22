#!/bin/bash

mkdir -p reports
REPORT="reports/monitor-$(date +%Y%m%d-%H%M%S).txt"

{
    echo "===================================="
    echo "       LINUX SERVER MONITOR"
    echo "===================================="
    echo "Date: $(date)"
    echo

    echo "[1] HOSTNAME"
    hostname
    echo

    echo "[2] SYSTEM UPTIME"
    uptime -p
    echo

    echo "[3] MEMORY USAGE"
    free -h

    MEMORY_AVAILABLE=$(free | awk '/Mem:/ {printf "%.0f", $7/$2*100}')

    if [ "$MEMORY_AVAILABLE" -lt 20 ]; then
        echo "WARNING: Available memory is ${MEMORY_AVAILABLE}%"
    else
        echo "OK: Available memory is ${MEMORY_AVAILABLE}%"
    fi
    echo

    echo "[4] DISK USAGE"
    df -h /

    DISK_USAGE=$(df / | awk 'NR==2 {gsub("%","",$5); print $5}')

    if [ "$DISK_USAGE" -ge 80 ]; then
        echo "WARNING: Disk usage is ${DISK_USAGE}%"
    else
        echo "OK: Disk usage is ${DISK_USAGE}%"
    fi
    echo

    echo "[5] NETWORK INFORMATION"
    ip -brief address
    echo

    echo "[6] DNS RESOLUTION TEST"
    if getent hosts github.com > /dev/null 2>&1; then
        echo "DNS Status: OK"
    else
        echo "DNS Status: FAILED"
    fi
    echo

    echo "[7] SYSTEM LOAD"
    cat /proc/loadavg
    echo

    echo "[8] INTERNET CONNECTIVITY"
    if curl -Is --connect-timeout 5 https://github.com > /dev/null 2>&1; then
        INTERNET_STATUS="OK"
        echo "Internet Status: OK"
    else
        INTERNET_STATUS="FAILED"
        echo "Internet Status: FAILED"
    fi
    echo

    echo "[9] FINAL SUMMARY"
    echo "Disk Usage: ${DISK_USAGE}%"
    echo "Available Memory: ${MEMORY_AVAILABLE}%"
    echo "Internet: ${INTERNET_STATUS}"

    if [ "$DISK_USAGE" -ge 80 ] || \
       [ "$MEMORY_AVAILABLE" -lt 20 ] || \
       [ "$INTERNET_STATUS" = "FAILED" ]; then
        echo "Overall Status: WARNING"
    else
        echo "Overall Status: HEALTHY"
    fi
    echo

    echo "Report saved to: $REPORT"
    echo "===================================="
} | tee "$REPORT"

if [ "$DISK_USAGE" -ge 80 ] || \
   [ "$MEMORY_AVAILABLE" -lt 20 ] || \
   [ "$INTERNET_STATUS" = "FAILED" ]; then
    exit 1
else
    exit 0
fi

#!/bin/bash

# Thresholds
CPU_THRESHOLD=80
MEM_THRESHOLD=80
DISK_THRESHOLD=80

LOG_FILE="./system_health.log"

cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
mem_usage=$(free | awk '/Mem/ {printf("%.0f"), $3/$2 * 100}')
disk_usage=$(df / | awk '/\// {print $5}' | sed 's/%//')

echo "CPU: $cpu_usage% | Memory: $mem_usage% | Disk: $disk_usage%" | tee -a $LOG_FILE

if (( ${cpu_usage%.*} > CPU_THRESHOLD )); then
    echo "⚠ ALERT: CPU usage high!" | tee -a $LOG_FILE
fi

if (( mem_usage > MEM_THRESHOLD )); then
    echo "⚠ ALERT: Memory usage high!" | tee -a $LOG_FILE
fi

if (( disk_usage > DISK_THRESHOLD )); then
    echo "⚠ ALERT: Disk usage high!" | tee -a $LOG_FILE
fi

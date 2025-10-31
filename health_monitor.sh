#!/bin/bash

LOGFILE="system_health.log"

CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
MEM=$(free | awk '/Mem/ {printf "%.2f", $3/$2 * 100}')
DISK=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

echo "CPU: $CPU% | Memory: $MEM% | Disk: $DISK%" | tee -a $LOGFILE

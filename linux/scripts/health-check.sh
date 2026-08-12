#!/bin/bash

echo "===================================="
echo "       SYSTEM HEALTH CHECK"
echo "===================================="

echo
echo "----- CPU -----"
top -bn1 | grep "Cpu(s)" | awk '{print "CPU Usage: " $2 + $4 "%"}'

echo
echo "----- MEMORY -----"
free -h

echo
echo "----- DISK -----"
df -h

echo
echo "----- PROCESSES -----"
echo "Total Processes: $(ps -e --no-headers | wc -l)"

echo
echo "Top 5 CPU Processes:"
ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -6

echo
echo "----- SERVICES -----"

services=("sshd" "cron")

for service in "${services[@]}"
do
    if systemctl is-active --quiet "$service"; then
        echo "$service → RUNNING"
    else
        echo "$service → NOT RUNNING"
    fi
done

echo
echo "===================================="
echo "       HEALTH CHECK COMPLETE"
echo "===================================="

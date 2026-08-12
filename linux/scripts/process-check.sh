i#!/bin/bash

echo "===================================="
echo "        PROCESS CHECK"
echo "===================================="

echo
echo "Total Processes:"
ps -e --no-headers | wc -l

echo
echo "Top 10 CPU Consuming Processes:"
ps -eo pid,user,comm,%cpu,%mem --sort=-%cpu | head -11

echo
echo "Top 10 Memory Consuming Processes:"
ps -eo pid,user,comm,%cpu,%mem --sort=-%mem | head -11

echo
echo "Zombie Processes:"

ZOMBIES=$(ps -eo stat | grep -c "^Z")

if [ "$ZOMBIES" -eq 0 ]; then
    echo "No zombie processes found"
else
    echo "Zombie Processes Found: $ZOMBIES"
fi

echo
echo "===================================="
echo "       PROCESS CHECK COMPLETE"
echo "===================================="

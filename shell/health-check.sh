#!/bin/bash

# ==========================================
# Linux Health Check
# ==========================================

echo "=========================================="
echo "        SYSTEM HEALTH CHECK"
echo "=========================================="

echo ""
echo "Hostname:"
hostname

echo ""
echo "Date:"
date

echo ""
echo "Uptime:"
uptime

echo ""
echo "------------------------------------------"
echo "CPU Information"
echo "------------------------------------------"

nproc

echo ""
echo "------------------------------------------"
echo "Memory Usage"
echo "------------------------------------------"

free -h

echo ""
echo "------------------------------------------"
echo "Disk Usage"
echo "------------------------------------------"

df -h

echo ""
echo "------------------------------------------"
echo "Top CPU Processes"
echo "------------------------------------------"

ps aux --sort=-%cpu | head -6

echo ""
echo "------------------------------------------"
echo "Top Memory Processes"
echo "------------------------------------------"

ps aux --sort=-%mem | head -6

echo ""
echo "------------------------------------------"
echo "Health Check Completed"
echo "------------------------------------------"

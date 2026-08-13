#!/bin/bash

# ==========================================
# Port Connectivity Check
# ==========================================

HOST="$1"
PORT="$2"

if [ -z "$HOST" ] || [ -z "$PORT" ]; then
    echo "Usage:"
    echo "./port-check.sh <host> <port>"
    echo ""
    echo "Example:"
    echo "./port-check.sh localhost 6379"
    exit 1
fi

echo "Checking $HOST:$PORT"
echo "------------------------------------------"

if nc -z -w 3 "$HOST" "$PORT" 2>/dev/null; then
    echo "$HOST:$PORT - OPEN"
else
    echo "$HOST:$PORT - CLOSED or UNREACHABLE"
    exit 1
fi

i#!/bin/bash

echo "===================================="
echo "          PORT CHECK"
echo "===================================="

check_port() {
    PORT=$1

    if timeout 2 bash -c "</dev/tcp/127.0.0.1/$PORT" 2>/dev/null
    then
        echo "$PORT → OPEN"
    else
        echo "$PORT → CLOSED"
    fi
}

echo
echo "Redis       6379"
check_port 6379

echo "SSH         22"
check_port 22

echo "HTTP        80"
check_port 80

echo "HTTPS       443"
check_port 443

echo
echo "===================================="
echo "          PORT CHECK COMPLETE"
echo "===================================="

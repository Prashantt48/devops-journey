#!/bin/bash

echo "===================================="
echo "        SERVICE CHECK"
echo "===================================="

SERVICES=("sshd" "cron" "rsyslog")

for SERVICE in "${SERVICES[@]}"
do
    echo
    echo "Checking service: $SERVICE"

    if systemctl list-unit-files | grep -q "^$SERVICE.service"; then

        if systemctl is-active --quiet "$SERVICE"; then
            echo "$SERVICE → RUNNING"
        else
            echo "$SERVICE → STOPPED"
        fi

    else
        echo "$SERVICE → NOT INSTALLED"
    fi
done

echo
echo "===================================="
echo "       SERVICE CHECK COMPLETE"
echo "===================================="

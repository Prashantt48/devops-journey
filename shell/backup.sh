#!/bin/bash

# ==========================================
# Backup Script
# ==========================================

SOURCE_DIR="$HOME/devops-data"
BACKUP_DIR="$HOME/devops-backups"

DATE=$(date +"%Y-%m-%d_%H-%M-%S")

BACKUP_FILE="$BACKUP_DIR/backup_$DATE.tar.gz"

echo "=========================================="
echo "        DevOps Backup Script"
echo "=========================================="

# Check source directory
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Source directory does not exist:"
    echo "$SOURCE_DIR"
    exit 1
fi

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Create backup
tar -czf "$BACKUP_FILE" "$SOURCE_DIR"

if [ $? -eq 0 ]; then
    echo "Backup completed successfully."
    echo "Backup file:"
    echo "$BACKUP_FILE"
else
    echo "Backup failed."
    exit 1
fi

echo "=========================================="

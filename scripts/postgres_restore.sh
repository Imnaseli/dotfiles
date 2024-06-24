#!/bin/bash

# Restore script for PostgreSQL in Docker

# Set variables
CONTAINER_NAME="buy-me-zobo-db"
POSTGRES_USER="postgres"
POSTGRES_DB="mydb"
BACKUP_DIR="/home/sijirama/.backup"

# Find the latest backup file
LATEST_BACKUP=$(ls -t $BACKUP_DIR/postgres_backup_*.sql.gz | head -n1)

if [ -z "$LATEST_BACKUP" ]; then
    echo "No backup file found in $BACKUP_DIR"
    exit 1
fi

echo "Latest backup file: $LATEST_BACKUP"
echo "Are you sure you want to restore this backup? This will overwrite the current database. (y/n)"
read -r confirm

if [ "$confirm" != "y" ]; then
    echo "Restore cancelled."
    exit 0
fi

# Restore the backup
gunzip < "$LATEST_BACKUP" | docker exec -i $CONTAINER_NAME psql -U $POSTGRES_USER -d $POSTGRES_DB

echo "Restore completed from: $LATEST_BACKUP"

#!/bin/bash

# Backup script for PostgreSQL in Docker

# Set variables
CONTAINER_NAME="buy-me-zobo-db"
POSTGRES_USER="postgres"
POSTGRES_DB="mydb"
BACKUP_DIR="/home/sijirama/backup"
DATE=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="$BACKUP_DIR/postgres_backup_$DATE.sql.gz"

# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# Perform the backup
docker exec $CONTAINER_NAME pg_dump -U $POSTGRES_USER $POSTGRES_DB | gzip > $BACKUP_FILE

# Delete backups older than 30 days
find $BACKUP_DIR -name "postgres_backup_*.sql.gz" -mtime +30 -delete

echo "Backup completed: $BACKUP_FILE"

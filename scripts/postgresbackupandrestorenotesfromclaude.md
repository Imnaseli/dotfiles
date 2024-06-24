Based on your Docker Compose file, I'll provide two scripts for backing up and restoring your PostgreSQL database. Here's how we'll approach this:

1. Backup script (to be run by cron every 3 days)
2. Restore script (to be run manually when needed)

Let's start with the backup script:

```bash
#!/bin/bash

# Backup script for PostgreSQL in Docker

# Set variables
CONTAINER_NAME="buy-me-zobo-db"
POSTGRES_USER="postgres"
POSTGRES_DB="mydb"
BACKUP_DIR="/path/to/backup/directory"
DATE=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="$BACKUP_DIR/postgres_backup_$DATE.sql.gz"

# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# Perform the backup
docker exec $CONTAINER_NAME pg_dump -U $POSTGRES_USER $POSTGRES_DB | gzip > $BACKUP_FILE

# Delete backups older than 30 days
find $BACKUP_DIR -name "postgres_backup_*.sql.gz" -mtime +30 -delete

echo "Backup completed: $BACKUP_FILE"
```

To set up the cron job to run this script every 3 days:

1. Save the script as `postgres_backup.sh` in a suitable location (e.g., `/home/user/scripts/postgres_backup.sh`).
2. Make it executable: `chmod +x /home/user/scripts/postgres_backup.sh`
3. Edit the crontab: `crontab -e`
4. Add this line to run the script every 3 days at 2 AM:
   ```
   0 2 */3 * * /home/user/scripts/postgres_backup.sh
   ```

Now, let's create the restore script:

```bash
#!/bin/bash

# Restore script for PostgreSQL in Docker

# Set variables
CONTAINER_NAME="buy-me-zobo-db"
POSTGRES_USER="postgres"
POSTGRES_DB="mydb"
BACKUP_DIR="/path/to/backup/directory"

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
```

Save this script as `postgres_restore.sh` and make it executable with `chmod +x postgres_restore.sh`.

To use the restore script, simply run it manually when needed:

```
./postgres_restore.sh
```

Remember to replace `/path/to/backup/directory` in both scripts with the actual path where you want to store your backups.

These scripts assume that:
1. The Docker container is running when the scripts are executed.
2. The user running the scripts has permission to execute Docker commands.
3. There's enough disk space in the backup directory.

Make sure to test both scripts thoroughly in a safe environment before using them in production.

Would you like me to explain any part of these scripts or provide any additional information?

#!/bin/bash

# Exit immediately on any error
set -e

# Function to log messages
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# Check arguments
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <source_directory> <backup_directory>"
    exit 1
fi

SOURCE_DIR="$1"
BACKUP_DIR="$2"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
ARCHIVE_NAME="backup-$TIMESTAMP.tar.gz"
LOG_FILE="$BACKUP_DIR/backup.log"

# Check if source exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Source directory '$SOURCE_DIR' does not exist." >&2
    exit 2
fi

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Log start
log_message "Starting backup of '$SOURCE_DIR' to '$BACKUP_DIR/$ARCHIVE_NAME'"

# Create the archive
tar -czf "$BACKUP_DIR/$ARCHIVE_NAME" -C "$(dirname "$SOURCE_DIR")" "$(basename "$SOURCE_DIR")"

# Log success
log_message "Backup completed successfully: '$ARCHIVE_NAME'"

# Exit successfully
exit 0

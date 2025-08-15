#!/bin/bash

# ENV VRS
DB_FILE="test.duckdb"
NUM_RECORDS=50000

# Check if the database file exists and remove it to start fresh
if [ -f "$DB_FILE" ]; then
    echo "Removing existing database file: $DB_FILE"
    rm "$DB_FILE"
fi

echo "Creating new DuckDB database and populating with test data..."

python3 scripts/generate_data.py --db-file $DB_FILE --num-records $NUM_RECORDS

echo "Script finished. Your database is ready at $DB_FILE"
echo "You can connect to it using: duckdb $DB_FILE"
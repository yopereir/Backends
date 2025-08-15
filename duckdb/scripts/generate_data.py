import duckdb
import pandas as pd
import numpy as np
import random
from datetime import datetime, timedelta
import argparse

# --- Set up command-line argument parsing ---
parser = argparse.ArgumentParser(description="Populate a DuckDB database with test sales data.")

parser.add_argument(
    "--db-file", 
    type=str, 
    default="analytics_test_data.duckdb", 
    help="The name of the DuckDB file to create. (default: analytics_test_data.duckdb)"
)

parser.add_argument(
    "--num-records", 
    type=int, 
    default=100000, 
    help="The number of records to generate for the sales table. (default: 100000)"
)

args = parser.parse_args()

# --- Access the arguments ---
DB_FILE = args.db_file
NUM_RECORDS = args.num_records

print(f"Using database file: {DB_FILE}")
print(f"Generating {NUM_RECORDS} records...")
print("-" * 30)

# Connect to the DuckDB database
con = duckdb.connect(database=DB_FILE, read_only=False)

# --- Define the schema for our test data ---
print("Creating sales table...")

con.execute("""
CREATE TABLE IF NOT EXISTS sales (
    sale_id VARCHAR,
    product_name VARCHAR,
    category VARCHAR,
    sale_date DATE,
    quantity INTEGER,
    price DECIMAL(10, 2)
);
""")

# --- Generate sample data using pandas ---
print("Generating sample data...")

products = ['Laptop', 'Mouse', 'Keyboard', 'Monitor', 'Webcam', 'Microphone']
categories = ['Electronics', 'Accessories']

# Generate a list of random dates within the last year
end_date = datetime.now()
start_date = end_date - timedelta(days=365)
date_range = [start_date + timedelta(days=random.randint(0, 365)) for _ in range(NUM_RECORDS)]

data = {
    'sale_id': [f"sale_{i}" for i in range(NUM_RECORDS)],
    'product_name': np.random.choice(products, NUM_RECORDS),
    'category': np.random.choice(categories, NUM_RECORDS),
    'sale_date': date_range,
    'quantity': np.random.randint(1, 10, NUM_RECORDS),
    'price': np.round(np.random.uniform(10, 1000, NUM_RECORDS), 2)
}

df = pd.DataFrame(data)

# Convert dates to a format DuckDB can ingest easily
df['sale_date'] = df['sale_date'].dt.strftime('%Y-%m-%d')

# --- Insert the data into the DuckDB table ---
print("Inserting data into the sales table...")

con.execute("INSERT INTO sales SELECT * FROM df")

# --- Verify the data has been inserted ---
result = con.execute("SELECT COUNT(*) FROM sales").fetchone()
print(f"Successfully inserted {result[0]} records.")

# Close the connection
con.close()
print("Script finished.")
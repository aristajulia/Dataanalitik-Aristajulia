
import pandas as pd
import sqlite3

# Load CSV files
penjualan = pd.read_csv("data/table_penjualan.csv")
produksi = pd.read_csv("data/table_produksi.csv")

# Create SQLite in-memory database
conn = sqlite3.connect(":memory:")

# Load data into the database
penjualan.to_sql("table_penjualan", conn, index=False, if_exists="replace")
produksi.to_sql("table_produksi", conn, index=False, if_exists="replace")

# Execute the query
query = open("sql/query.sql", "r").read()
result = pd.read_sql_query(query, conn)

# Save the result to a CSV file
result.to_csv("output/result.csv", index=False)
print("Query executed successfully. Results saved to output/result.csv.")

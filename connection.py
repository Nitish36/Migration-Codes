import sqlite3

# Connects to (or creates) a SQLite .db file
conn = sqlite3.connect("order.db")
cursor = conn.cursor()

# Read your SQL from a file
with open("orders.sql", "r") as f:
    sql = f.read()
    cursor.executescript(sql)

conn.commit()
conn.close()

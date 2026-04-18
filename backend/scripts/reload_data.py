import os
import sys
import time
from neo4j import GraphDatabase
from dotenv import load_dotenv

load_dotenv()

uri = os.getenv("NEO4J_URI", "bolt://localhost:7687")
user = os.getenv("NEO4J_USER", "neo4j")
password = os.getenv("NEO4J_PASSWORD", "QAZplm6002")

def reload_data():
    file_path = "About_System/CypherQuery/CNTT.txt"
    if not os.path.exists(file_path):
        print(f"Error: {file_path} not found.")
        return

    print(f"Reading data from {file_path}...")
    with open(file_path, "r", encoding="utf-8") as f:
        cypher_script = f.read()

    statements = [s.strip() for s in cypher_script.split(";") if s.strip()]

    print(f"Connecting to Neo4j at {uri}...")
    
    driver = None
    max_retries = 5
    for i in range(max_retries):
        try:
            driver = GraphDatabase.driver(uri, auth=(user, password))
            # Test connection
            with driver.session() as session:
                session.run("RETURN 1")
            print("Connected successfully!")
            break
        except Exception as e:
            print(f"Attempt {i+1}/{max_retries} failed: {e}")
            if i < max_retries - 1:
                time.sleep(5)
            else:
                print("Failed to connect after several attempts.")
                return

    with driver.session() as session:
        print(f"Executing {len(statements)} statements...")
        for i, stmt in enumerate(statements):
            try:
                session.run(stmt)
                if i % 10 == 0:
                    print(f"Executed {i}/{len(statements)} statements...")
            except Exception as e:
                print(f"Error executing statement {i}.")
                # Print specifically avoiding unicode issues in cmd if possible
                try:
                    print(f"Reason: {str(e)[:200]}")
                except:
                    print("Reason: [Unicode error in error message]")

    print("Successfully reloaded Neo4j database with data from CNTT.txt!")
    driver.close()

if __name__ == "__main__":
    reload_data()

import os
import sys
from neo4j import GraphDatabase
from dotenv import load_dotenv

load_dotenv()

uri = os.getenv("NEO4J_URI", "bolt://localhost:7687")
user = os.getenv("NEO4J_USER", "neo4j")
password = os.getenv("NEO4J_PASSWORD", "QAZplm6002")

def seed_database():
    print(f"Connecting to Neo4j at {uri}...")
    try:
        driver = GraphDatabase.driver(uri, auth=(user, password))
    except Exception as e:
        print(f"Failed to connect: {e}")
        sys.exit(1)

    with driver.session() as session:
        print("Clearing existing data...")
        session.run("MATCH (n) DETACH DELETE n")

        print("Seeding new educational data...")
        cypher_seed = """
        CREATE (it101:Course {id: 'IT101', name: 'Nhập môn Lập trình', credits: 3})
        CREATE (it102:Course {id: 'IT102', name: 'Cấu trúc dữ liệu và Thuật toán', credits: 4})
        CREATE (it103:Course {id: 'IT103', name: 'Toán rời rạc', credits: 3})
        CREATE (it201:Course {id: 'IT201', name: 'Cơ sở dữ liệu', credits: 3})
        CREATE (it202:Course {id: 'IT202', name: 'Trí tuệ Nhân tạo', credits: 3})
        
        CREATE (it101)-[:PREREQUISITE_FOR]->(it102)
        CREATE (it103)-[:PREREQUISITE_FOR]->(it102)
        CREATE (it102)-[:PREREQUISITE_FOR]->(it201)
        CREATE (it102)-[:PREREQUISITE_FOR]->(it202)
        """
        session.run(cypher_seed)
        print("Successfully seeded Neo4j databases with sample courses and prerequisites!")
    driver.close()

if __name__ == "__main__":
    seed_database()

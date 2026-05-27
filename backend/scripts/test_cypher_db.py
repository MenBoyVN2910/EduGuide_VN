import os
import sys
from dotenv import load_dotenv

load_dotenv()
sys.path.append(os.path.join(os.getcwd(), 'backend'))

from app.core.neo4j_db import neo4j_db
neo4j_db.connect()
query = "MATCH (p:Course)-[:PREREQUISITE_FOR]->(c:Course) WHERE toLower(c.name) CONTAINS toLower('Lập trình web') RETURN p.name, p.credits, p.category LIMIT 20"
print("Results:", neo4j_db.execute_query(query))

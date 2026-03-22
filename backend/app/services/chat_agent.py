import os
import google.generativeai as genai
from app.core.neo4j_db import neo4j_db

# Configure Gemini
api_key = os.getenv("GEMINI_API_KEY")
if api_key:
    genai.configure(api_key=api_key)

generation_config = {
  "temperature": 0.2, # Low temperature to reduce hallucination
  "top_p": 0.95,
  "top_k": 40,
  "max_output_tokens": 1024,
}

model = genai.GenerativeModel(
    model_name="gemini-2.5-flash", 
    generation_config=generation_config
)

def search_neo4j_context(query: str) -> str:
    """
    Search Neo4j for relevant context based on user query.
    This is a mocked RAG retrieval step because dynamic Cypher generation
    is complex, but here we can generate standard Cypher based on keywords.
    """
    # Try connecting
    try:
        neo4j_db.connect()
    except Exception as e:
        return f"Warning: Neo4j connection failed ({str(e)}). No context retrieved."
        
    # In a real Graph RAG, we would use an LLM to generate Cypher or use Vector search
    # For this demo, let's do a basic full-text/keyword search if matched, or return all Courses
    # We will just fetch a few sample nodes to provide context
    try:
        query_cypher = """
        MATCH (c:Course) 
        OPTIONAL MATCH (p:Course)-[:PREREQUISITE_FOR]->(c)
        RETURN c.id AS id, c.name AS name, c.credits AS credits, collect(p.name) AS prerequisites
        LIMIT 20
        """
        results = neo4j_db.execute_query(query_cypher)
        if not results:
            return "No data found in Neo4j graph."
            
        context = "Here is some data from the Knowledge Graph:\n"
        for row in results:
            prereqs = row.get('prerequisites', [])
            prereq_str = f" (Môn tiên quyết: {', '.join(prereqs)})" if prereqs else ""
            context += f"- Khóa học {row.get('id', '')}: {row.get('name', '')} ({row.get('credits', '')} tín chỉ){prereq_str}\n"
        return context
    except Exception as e:
        return f"Error executing Cypher query: {str(e)}"

def process_chat_message(user_message: str) -> str:
    """Process message through Gemini augmented with Neo4j Data"""
    
    # 1. Retrieve Context from Neo4j
    context = search_neo4j_context(user_message)
    
    # 2. Construct Prompt for Gemini
    prompt = f"""You are ChatBoxAI, an educational assistant.
If the user's question is NOT related to the educational training program, universities, study paths, courses, or prerequisites, you MUST refuse to answer and EXACTLY reply with:
"Câu Hỏi Của Bạn Không Đúng Môn Học" 

If the question IS related to the training program, you must answer the user's question accurately using ONLY the information provided in the Context below.
If the context does not contain the answer, say "Tôi không có đủ thông tin trong cơ sở dữ liệu đồ thị để trả lời câu hỏi này." 
Do not hallucinate or make up courses.

Context from Enterprise Knowledge Graph (Neo4j):
{context}

User Question: {user_message}
Answer in Markdown format:"""

    try:
        response = model.generate_content(prompt)
        return response.text
    except Exception as e:
        return f"Lỗi xử lý từ AI: {str(e)}"

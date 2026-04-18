import os
import sys

# Thêm đường dẫn backend vào sys.path để có thể import từ app
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from app.services.chat_agent import generate_cypher

test_questions = [
    "Điều kiện tiên quyết của môn Lập trình web là gì?",
    "Ngành Công nghệ thông tin có bao nhiêu tín chỉ?"
]

for q in test_questions:
    print(f"Câu hỏi: {q}")
    cypher = generate_cypher(q)
    print(f"Cypher Query sinh ra:\n{cypher}\n")

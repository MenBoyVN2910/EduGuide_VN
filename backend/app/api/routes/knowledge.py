import logging

from fastapi import APIRouter, Depends, HTTPException, UploadFile, File
from sqlmodel import Session

from app.api.deps import get_current_user, get_db
from app.models import KnowledgeStats, User, Message, CypherQuery, CypherResult, GraphData, GraphNode, GraphRelationship
from app.core.neo4j_db import neo4j_db

router = APIRouter()
logger = logging.getLogger(__name__)

@router.get("/stats", response_model=KnowledgeStats)
def get_knowledge_stats(
    current_user: User = Depends(get_current_user),
) -> KnowledgeStats:
    """
    Lấy thông kê hệ thống Tri thức (Neo4j).
    """
    if not current_user.is_superuser:
        raise HTTPException(status_code=403, detail="Not enough permissions")
        
    health = neo4j_db.health_check()
    
    total_nodes = 0
    total_rels = 0
    
    if health.get("neo4j") == "healthy":
        try:
            with neo4j_db.session() as db_session:
                # Count nodes
                node_result = db_session.run("MATCH (n) RETURN count(n) as count")
                total_nodes = node_result.single()["count"]
                
                # Count relationships
                rel_result = db_session.run("MATCH ()-[r]->() RETURN count(r) as count")
                total_rels = rel_result.single()["count"]
        except Exception as e:
            logger.error(f"Failed to get neo4j stats: {e}")
            
    return KnowledgeStats(
        neo4j_status=health.get("neo4j", "unknown"),
        total_nodes=total_nodes,
        total_relationships=total_rels
    )

@router.post("/upload", response_model=Message)
async def upload_knowledge_document(
    file: UploadFile = File(...),
    current_user: User = Depends(get_current_user),
) -> Message:
    """
    Tải tài liệu lên để hệ thống học.
    (API Demo - Cần tích hợp với hệ thống chia nhỏ văn bản và tạo Vector Embeddings)
    """
    if not current_user.is_superuser:
        raise HTTPException(status_code=403, detail="Not enough permissions")
        
    # Đoạn này sẽ thực hiện logic đọc file, chunking, embedding và lưu vào Neo4j
    content = await file.read()
    
    return Message(message=f"Tài liệu {file.filename} đã được tải lên thành công. Kích thước: {len(content)} bytes.")

@router.post("/cypher", response_model=CypherResult)
def execute_cypher(
    query: CypherQuery,
    current_user: User = Depends(get_current_user),
) -> CypherResult:
    """
    Thực thi câu lệnh Cypher (Chỉ dành cho Admin).
    """
    if not current_user.is_superuser:
        raise HTTPException(status_code=403, detail="Not enough permissions")
        
    try:
        with neo4j_db.session() as db_session:
            result = db_session.run(query.query)
            data = []
            columns = result.keys()
            for record in result:
                # Convert Neo4j objects to dicts
                row_data = {}
                for key in columns:
                    val = record[key]
                    if hasattr(val, "element_id"):
                        # If it's a Node or Relationship, extract its properties
                        if hasattr(val, "labels"): # Node
                            row_data[key] = {
                                "id": val.element_id,
                                "labels": list(val.labels),
                                "properties": dict(val)
                            }
                        elif hasattr(val, "type"): # Relationship
                            row_data[key] = {
                                "id": val.element_id,
                                "type": val.type,
                                "properties": dict(val),
                                "start_node": val.start_node.element_id if hasattr(val, "start_node") else None,
                                "end_node": val.end_node.element_id if hasattr(val, "end_node") else None
                            }
                    else:
                        row_data[key] = val
                data.append(row_data)
            return CypherResult(data=data, columns=list(columns))
    except Exception as e:
        logger.error(f"Failed to execute cypher: {e}")
        raise HTTPException(status_code=400, detail=str(e))

@router.get("/graph", response_model=GraphData)
def get_graph_data(
    limit: int = 200,
    current_user: User = Depends(get_current_user),
) -> GraphData:
    """
    Lấy dữ liệu đồ thị (nodes và relationships) để hiển thị.
    """
    if not current_user.is_superuser:
        raise HTTPException(status_code=403, detail="Not enough permissions")
        
    try:
        with neo4j_db.session() as db_session:
            # Query for nodes
            node_result = db_session.run(f"MATCH (n) RETURN n LIMIT {limit}")
            nodes = []
            node_ids = set()
            for record in node_result:
                node = record["n"]
                node_id = node.element_id
                nodes.append(GraphNode(
                    id=node_id,
                    labels=list(node.labels),
                    properties=dict(node)
                ))
                node_ids.add(node_id)
                
            # Query for relationships between the fetched nodes
            links = []
            if node_ids:
                rel_result = db_session.run(f"MATCH (n)-[r]->(m) WHERE elementId(n) IN $node_ids AND elementId(m) IN $node_ids RETURN r LIMIT {limit * 2}", node_ids=list(node_ids))
                for record in rel_result:
                    rel = record["r"]
                    links.append(GraphRelationship(
                        id=rel.element_id,
                        source=rel.start_node.element_id,
                        target=rel.end_node.element_id,
                        type=rel.type,
                        properties=dict(rel)
                    ))
                    
            return GraphData(nodes=nodes, links=links)
    except Exception as e:
        logger.error(f"Failed to get graph data: {e}")
        raise HTTPException(status_code=400, detail=str(e))

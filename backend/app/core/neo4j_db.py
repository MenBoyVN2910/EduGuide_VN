"""
Quản lý kết nối cơ sở dữ liệu Neo4j với tính năng Connection Pooling (Nhóm kết nối).
Tối ưu hóa cho vòng đời của FastAPI (startup/shutdown).
"""

import logging
from contextlib import contextmanager
from neo4j import GraphDatabase, Driver
from app.core.config import settings

logger = logging.getLogger("neo4j_db")


class Neo4jConnection:
    """
    Trình quản lý kết nối Neo4j (Thread-safe) với cơ chế pooling có sẵn.
    """

    _driver: Driver | None = None

    def connect(self) -> None:
        """
        Khởi tạo Neo4j driver với các thiết lập về pooling và timeout.
        """
        if self._driver is not None:
            return # Đã kết nối rồi thì không tạo lại
            
        try:
            self._driver = GraphDatabase.driver(
                settings.NEO4J_URI,
                auth=(settings.NEO4J_USER, settings.NEO4J_PASSWORD),
                max_connection_pool_size=settings.NEO4J_MAX_POOL_SIZE,
                connection_timeout=settings.NEO4J_CONNECTION_TIMEOUT,
            )
            # Kiểm tra kết nối ngay lập tức
            self._driver.verify_connectivity()
            logger.info(
                "Đã kết nối Neo4j: %s (kích thước pool=%d)",
                settings.NEO4J_URI,
                settings.NEO4J_MAX_POOL_SIZE,
            )
        except Exception as e:
            self._driver = None
            logger.error("Kết nối Neo4j thất bại: %s", e)
            raise

    def close(self) -> None:
        """
        Đóng driver một cách an toàn và giải phóng các kết nối trong pool.
        """
        if self._driver:
            self._driver.close()
            self._driver = None
            logger.info("Đã đóng Driver Neo4j.")

    @property
    def is_connected(self) -> bool:
        """Kiểm tra xem driver có đang hoạt động không."""
        return self._driver is not None

    def health_check(self) -> dict:
        """
        Kiểm tra trạng thái sức khỏe của DB để trả về cho endpoint /health.
        """
        if not self._driver:
            return {"neo4j": "disconnected"}
        try:
            self._driver.verify_connectivity()
            return {"neo4j": "healthy"}
        except Exception as e:
            return {"neo4j": f"unhealthy: {e}"}

    @contextmanager
    def session(self):
        """
        Tạo một session từ pool, tự động đóng sau khi sử dụng (context manager).
        """
        if not self._driver:
            self.connect()
        sess = self._driver.session()
        try:
            yield sess
        finally:
            sess.close()

    def execute_query(self, query: str, parameters: dict | None = None) -> list[dict]:
        """
        Thực thi một câu lệnh truy vấn (READ) và trả về danh sách các bản ghi (dict).
        """
        with self.session() as sess:
            result = sess.run(query, parameters or {})
            return [record.data() for record in result]

    def get_schema_summary(self) -> str:
        """
        Tự động khám phá cấu trúc DB (Labels, Relationships) để AI nắm bắt được schema.
        """
        try:
            labels = self.execute_query(
                "CALL db.labels() YIELD label RETURN collect(label) AS labels"
            )
            rels = self.execute_query(
                "CALL db.relationshipTypes() YIELD relationshipType "
                "RETURN collect(relationshipType) AS types"
            )
            lbl_list = labels[0]["labels"] if labels else []
            rel_list = rels[0]["types"] if rels else []
            return f"Node labels: {lbl_list}. Relationship types: {rel_list}."
        except Exception as e:
            logger.warning("Không thể lấy Schema DB: %s", e)
            return ""


# Khởi tạo instance duy nhất (Singleton) cho toàn ứng dụng
neo4j_db = Neo4jConnection()

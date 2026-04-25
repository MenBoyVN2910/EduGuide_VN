// HUTECH K2025 - TOAN BO DU LIEU CHUONG TRINH DAO TAO
// Tong cong: 18 nganh dao tao + 1 node University
// Import: Copy toan bo noi dung vao Neo4j Browser roi chay

// BUOC 0: XOA DU LIEU CU
MATCH (n) DETACH DELETE n;

// === NGANH 1/18: 1.Công Nghệ Thông Tin K25_Cypher.txt ===
// =============================================================================
// CHƯƠNG TRÌNH ĐÀO TẠO NGÀNH CÔNG NGHỆ THÔNG TIN (7480201) - ĐẠI HỌC HUTECH
// Tổng khối lượng: 150 tín chỉ tích lũy + 5 tín chỉ không tích lũy
// =============================================================================

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 0: XÓA DỮ LIỆU CŨ (chạy 1 lần trước khi import)    ║
// ╚══════════════════════════════════════════════════════════════╝

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 1: TẠO NODE NGÀNH                                     ║
// ╚══════════════════════════════════════════════════════════════╝
MERGE (:Major {id: '7480201', name: 'Công nghệ thông tin', university: 'HUTECH', total_credits: 150, non_accum_credits: 5});

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 2: TẠO TẤT CẢ NODE MÔN HỌC                           ║
// ╚══════════════════════════════════════════════════════════════╝

// ────────────────────────────────────────────────────────────────
// I. KIẾN THỨC GIÁO DỤC ĐẠI CƯƠNG (50 tín chỉ)
// ────────────────────────────────────────────────────────────────
MERGE (:Course {id: 'POS104', name: 'Triết học Mác - Lênin', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'POS105', name: 'Kinh tế chính trị Mác - Lênin', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS106', name: 'Chủ nghĩa xã hội khoa học', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS107', name: 'Lịch sử Đảng Cộng sản Việt Nam', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS103', name: 'Tư tưởng Hồ Chí Minh', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'ENC120', name: 'Anh ngữ 1', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC121', name: 'Anh ngữ 2', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC122', name: 'Anh ngữ 3', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC123', name: 'Anh ngữ 4', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENS192', name: 'Phát triển bền vững', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'LAW106', name: 'Pháp luật đại cương', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'SKL115', name: 'Tư duy thiết kế dự án', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'SKL116', name: 'Đổi mới sáng tạo và tư duy khởi nghiệp', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'CMP6084', name: 'Nhập môn ngành Công nghệ thông tin', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'MAT101', name: 'Đại số tuyến tính', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'MAT118', name: 'Giải tích', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'MAT105', name: 'Xác suất thống kê', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'MAT104', name: 'Toán rời rạc', credits: 3, category: 'Đại cương'});

// ────────────────────────────────────────────────────────────────
// II.1. KIẾN THỨC CHUYÊN NGHIỆP BẮT BUỘC (91 tín chỉ)
// ────────────────────────────────────────────────────────────────

// --- Môn lý thuyết chính ---
MERGE (:Course {id: 'COS1001', name: 'Cơ sở an toàn thông tin và máy chủ', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'COS1002', name: 'Các hệ quản trị cơ sở dữ liệu', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP1074', name: 'Cơ sở lập trình', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP164', name: 'Kỹ thuật lập trình', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP167', name: 'Lập trình hướng đối tượng', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'COS135', name: 'Nhập môn cơ sở dữ liệu', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'AIT104', name: 'Máy học', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'COS120', name: 'Cấu trúc dữ liệu và giải thuật', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'COS117', name: 'Kiến trúc và hệ điều hành máy tính', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'COS129', name: 'Điện toán đám mây', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP174', name: 'Bảo mật thông tin', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP101', name: 'Công nghệ phần mềm', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP180', name: 'Lập trình mạng máy tính', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP170', name: 'Lập trình trên môi trường Windows', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP177', name: 'Lập trình trên thiết bị di động', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP175', name: 'Lập trình web', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP172', name: 'Mạng máy tính', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP184', name: 'Phân tích thiết kế hệ thống', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAN104', name: 'Quản lý dự án công nghệ thông tin', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'AIT1001', name: 'Cơ sở trí tuệ nhân tạo', credits: 3, category: 'Chuyên nghiệp bắt buộc'});

// --- Môn thực hành ---
MERGE (:Course {id: 'CMP3087', name: 'Thực hành an toàn hệ điều hành máy chủ', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP382', name: 'Thực hành bảo mật thông tin', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP3088', name: 'Thực hành lập trình bảo mật hệ thống', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'COS321', name: 'Thực hành cấu trúc dữ liệu và giải thuật', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'COS323', name: 'Thực hành cơ sở dữ liệu', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP5089', name: 'Thực tập điện toán đám mây', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP3090', name: 'Thực hành kiến trúc và hệ điều hành máy tính', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP3075', name: 'Thực hành cơ sở lập trình', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP365', name: 'Thực hành kỹ thuật lập trình', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP368', name: 'Thực hành lập trình hướng đối tượng', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP381', name: 'Thực hành lập trình mạng máy tính', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP371', name: 'Thực hành lập trình trên môi trường Windows', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP376', name: 'Thực hành lập trình web', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP3014', name: 'Thực hành lý thuyết đồ thị', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP373', name: 'Thực hành mạng máy tính', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP385', name: 'Thực hành phân tích thiết kế hệ thống', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP3019', name: 'Thực hành phân tích thiết kế theo hướng đối tượng', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'COS340', name: 'Thực hành phát triển phần mềm mã nguồn mở', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'COS324', name: 'Thực hành quản trị cơ sở dữ liệu', credits: 1, category: 'Chuyên nghiệp bắt buộc'});

// --- Môn đặc biệt ---
MERGE (:Course {id: 'AIT1002', name: 'Nghệ thuật lập trình với hỗ trợ trí tuệ nhân tạo', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP5091', name: 'Thực tập cơ sở ngành Công nghệ thông tin', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP436', name: 'Đồ án chuyên ngành Công nghệ thông tin', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP596', name: 'Thực tập tốt nghiệp ngành Công nghệ thông tin', credits: 3, category: 'Chuyên nghiệp bắt buộc'});

// ────────────────────────────────────────────────────────────────
// II.2. KIẾN THỨC TỰ CHỌN (chọn 9 tín chỉ / 3 môn từ 1 nhóm)
// ────────────────────────────────────────────────────────────────

// Nhóm 1: Công nghệ phần mềm
MERGE (:Course {id: 'CMP179', name: 'Kiểm thử và đảm bảo chất lượng phần mềm', credits: 3, category: 'Tự chọn - Công nghệ phần mềm'});
MERGE (:Course {id: 'CAP126', name: 'Ngôn ngữ phát triển ứng dụng mới', credits: 3, category: 'Tự chọn - Công nghệ phần mềm'});
MERGE (:Course {id: 'COS141', name: 'Phát triển ứng dụng với J2EE', credits: 3, category: 'Tự chọn - Công nghệ phần mềm'});

// Nhóm 2: Hệ thống thông tin ứng dụng
MERGE (:Course {id: 'COS1003', name: 'Phân tích nghiệp vụ', credits: 3, category: 'Tự chọn - Hệ thống thông tin ứng dụng'});
MERGE (:Course {id: 'AIT1003', name: 'Khoa học dữ liệu phân tán', credits: 3, category: 'Tự chọn - Hệ thống thông tin ứng dụng'});
MERGE (:Course {id: 'CMP1059', name: 'Phân tích dữ liệu lớn', credits: 3, category: 'Tự chọn - Hệ thống thông tin ứng dụng'});

// Nhóm 3: Mạng máy tính
MERGE (:Course {id: 'CMP1092', name: 'Quản trị dịch vụ mạng trên điện toán đám mây', credits: 3, category: 'Tự chọn - Mạng máy tính'});
MERGE (:Course {id: 'COS128', name: 'Hệ điều hành Linux', credits: 3, category: 'Tự chọn - Mạng máy tính'});
MERGE (:Course {id: 'COS1004', name: 'Phân tích đánh giá hiệu suất mạng', credits: 3, category: 'Tự chọn - Mạng máy tính'});

// Nhóm 4: Máy học và ứng dụng
MERGE (:Course {id: 'CMP1020', name: 'Học sâu', credits: 3, category: 'Tự chọn - Máy học và ứng dụng'});
MERGE (:Course {id: 'CMP1021', name: 'Thị giác máy tính', credits: 3, category: 'Tự chọn - Máy học và ứng dụng'});
MERGE (:Course {id: 'CMP1022', name: 'Trí tuệ nhân tạo cho internet vạn vật', credits: 3, category: 'Tự chọn - Máy học và ứng dụng'});

// Nhóm 5: An ninh mạng
MERGE (:Course {id: 'CMP194', name: 'An toàn thông tin cho ứng dụng web', credits: 3, category: 'Tự chọn - An ninh mạng'});
MERGE (:Course {id: 'COS1005', name: 'An toàn hệ thống mạng máy tính và đám mây', credits: 3, category: 'Tự chọn - An ninh mạng'});
MERGE (:Course {id: 'CMP193', name: 'Phân tích và đánh giá an toàn thông tin', credits: 3, category: 'Tự chọn - An ninh mạng'});

// Nhóm 6: Đồ án tốt nghiệp
MERGE (:Course {id: 'COS4006', name: 'Đồ án tốt nghiệp Công nghệ thông tin', credits: 9, category: 'Tự chọn - Đồ án tốt nghiệp'});

// ────────────────────────────────────────────────────────────────
// III. KIẾN THỨC KHÔNG TÍCH LŨY
// ────────────────────────────────────────────────────────────────

// III.1. Giáo dục thể chất (chọn 1 trong 5 nhóm, 5 tín chỉ)
// Nhóm 1: Bóng chuyền
MERGE (:Course {id: 'PHT304', name: 'Bóng chuyền 1', credits: 2, category: 'Thể chất - Bóng chuyền'});
MERGE (:Course {id: 'PHT305', name: 'Bóng chuyền 2', credits: 2, category: 'Thể chất - Bóng chuyền'});
MERGE (:Course {id: 'PHT306', name: 'Bóng chuyền 3', credits: 1, category: 'Thể chất - Bóng chuyền'});

// Nhóm 2: Bóng rổ
MERGE (:Course {id: 'PHT307', name: 'Bóng rổ 1', credits: 2, category: 'Thể chất - Bóng rổ'});
MERGE (:Course {id: 'PHT308', name: 'Bóng rổ 2', credits: 2, category: 'Thể chất - Bóng rổ'});
MERGE (:Course {id: 'PHT309', name: 'Bóng rổ 3', credits: 1, category: 'Thể chất - Bóng rổ'});

// Nhóm 3: Thể hình - Thẩm mỹ
MERGE (:Course {id: 'PHT310', name: 'Thể hình - Thẩm mỹ 1', credits: 2, category: 'Thể chất - Thể hình Thẩm mỹ'});
MERGE (:Course {id: 'PHT311', name: 'Thể hình - Thẩm mỹ 2', credits: 2, category: 'Thể chất - Thể hình Thẩm mỹ'});
MERGE (:Course {id: 'PHT312', name: 'Thể hình - Thẩm mỹ 3', credits: 1, category: 'Thể chất - Thể hình Thẩm mỹ'});

// Nhóm 4: Vovinam
MERGE (:Course {id: 'PHT313', name: 'Vovinam 1', credits: 2, category: 'Thể chất - Vovinam'});
MERGE (:Course {id: 'PHT314', name: 'Vovinam 2', credits: 2, category: 'Thể chất - Vovinam'});
MERGE (:Course {id: 'PHT315', name: 'Vovinam 3', credits: 1, category: 'Thể chất - Vovinam'});

// Nhóm 5: Bóng đá
MERGE (:Course {id: 'PHT316', name: 'Bóng đá 1', credits: 2, category: 'Thể chất - Bóng đá'});
MERGE (:Course {id: 'PHT317', name: 'Bóng đá 2', credits: 2, category: 'Thể chất - Bóng đá'});
MERGE (:Course {id: 'PHT318', name: 'Bóng đá 3', credits: 1, category: 'Thể chất - Bóng đá'});

// III.2. Giáo dục Quốc phòng và An ninh
MERGE (:Course {id: 'NDF108', name: 'Quốc phòng, an ninh 1', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF109', name: 'Quốc phòng, an ninh 2', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF210', name: 'Quốc phòng, an ninh 3', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF211', name: 'Quốc phòng, an ninh 4', credits: 0, category: 'Quốc phòng An ninh'});

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 3: LIÊN KẾT MÔN HỌC VỚI NGÀNH                        ║
// ╚══════════════════════════════════════════════════════════════╝
MATCH (c:Course), (m:Major {id: '7480201'})
WHERE c.id IN [
    'POS104', 'POS105', 'POS106', 'POS107', 'POS103', 'ENC120', 'ENC121', 'ENC122',
    'ENC123', 'ENS192', 'LAW106', 'SKL115', 'SKL116', 'CMP6084', 'MAT101', 'MAT118',
    'MAT105', 'MAT104', 'COS1001', 'COS1002', 'CMP1074', 'CMP164', 'CMP167', 'COS135',
    'AIT104', 'COS120', 'COS117', 'COS129', 'CMP174', 'CMP101', 'CMP180', 'CMP170',
    'CMP177', 'CMP175', 'CMP172', 'CMP184', 'MAN104', 'AIT1001', 'CMP3087', 'CMP382',
    'CMP3088', 'COS321', 'COS323', 'CMP5089', 'CMP3090', 'CMP3075', 'CMP365', 'CMP368',
    'CMP381', 'CMP371', 'CMP376', 'CMP3014', 'CMP373', 'CMP385', 'CMP3019', 'COS340',
    'COS324', 'AIT1002', 'CMP5091', 'CMP436', 'CMP596', 'CMP179', 'CAP126', 'COS141',
    'COS1003', 'AIT1003', 'CMP1059', 'CMP1092', 'COS128', 'COS1004', 'CMP1020', 'CMP1021',
    'CMP1022', 'CMP194', 'COS1005', 'CMP193', 'COS4006', 'PHT304', 'PHT305', 'PHT306',
    'PHT307', 'PHT308', 'PHT309', 'PHT310', 'PHT311', 'PHT312', 'PHT313', 'PHT314',
    'PHT315', 'PHT316', 'PHT317', 'PHT318', 'NDF108', 'NDF109', 'NDF210', 'NDF211'
]
MERGE (c)-[:BELONGS_TO]->(m);

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 4: MÔN TIÊN QUYẾT (PREREQUISITE_FOR)                  ║
// ║  Chiều: (Môn phải học trước)-[:PREREQUISITE_FOR]->(Môn sau)  ║
// ╚══════════════════════════════════════════════════════════════╝

// --- Anh ngữ: chuỗi tiên quyết ---
MATCH (a:Course {id: 'ENC122'}), (b:Course {id: 'ENC123'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// --- Kỹ năng ---
MATCH (a:Course {id: 'SKL115'}), (b:Course {id: 'SKL116'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// --- Lập trình cốt lõi ---
MATCH (a:Course {id: 'CMP1074'}), (b:Course {id: 'CMP164'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'CMP164'}), (b:Course {id: 'COS120'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// --- Lập trình nâng cao (cần CMP167 Lập trình HĐT) ---
MATCH (a:Course {id: 'CMP167'}), (b:Course {id: 'CMP174'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'CMP167'}), (b:Course {id: 'CMP175'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'CMP167'}), (b:Course {id: 'CMP177'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'CMP167'}), (b:Course {id: 'CMP170'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// --- Mạng ---
MATCH (a:Course {id: 'CMP172'}), (b:Course {id: 'CMP180'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// --- Quản lý dự án ---
MATCH (a:Course {id: 'CMP101'}), (b:Course {id: 'MAN104'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 5: MÔN SONG HÀNH (COREQUISITE_WITH)                   ║
// ║  Thực hành đi đôi với lý thuyết                              ║
// ╚══════════════════════════════════════════════════════════════╝

// --- Anh ngữ song hành ---
MATCH (a:Course {id: 'ENC121'}), (b:Course {id: 'ENC120'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'ENC122'}), (b:Course {id: 'ENC121'}) MERGE (a)-[:COREQUISITE_WITH]->(b);

// --- Thực hành song hành với lý thuyết ---
MATCH (a:Course {id: 'CMP3075'}), (b:Course {id: 'CMP1074'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'CMP365'}), (b:Course {id: 'CMP164'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'CMP368'}), (b:Course {id: 'CMP167'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'COS321'}), (b:Course {id: 'COS120'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'COS323'}), (b:Course {id: 'COS135'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'CMP3090'}), (b:Course {id: 'COS117'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'CMP5089'}), (b:Course {id: 'COS129'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'CMP382'}), (b:Course {id: 'CMP174'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'CMP381'}), (b:Course {id: 'CMP180'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'CMP371'}), (b:Course {id: 'CMP170'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'CMP376'}), (b:Course {id: 'CMP175'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'CMP373'}), (b:Course {id: 'CMP172'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'CMP3019'}), (b:Course {id: 'CMP184'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'COS324'}), (b:Course {id: 'COS1002'}) MERGE (a)-[:COREQUISITE_WITH]->(b);


// === NGANH 2/18: 2.Marketing K25_Cypher.txt ===
// =============================================================================
// CHƯƠNG TRÌNH ĐÀO TẠO NGÀNH MARKETING (7340115) - ĐẠI HỌC HUTECH
// Đối tượng áp dụng: Đại học hệ chính quy từ khóa tuyển sinh năm 2025
// Tổng khối lượng: 125 tín chỉ tích lũy + 5 tín chỉ không tích lũy
// =============================================================================

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 0: XÓA DỮ LIỆU CŨ (chạy 1 lần trước khi import)    ║
// ╚══════════════════════════════════════════════════════════════╝

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 1: TẠO NODE NGÀNH                                     ║
// ╚══════════════════════════════════════════════════════════════╝
MERGE (:Major {id: '7340115', name: 'Marketing', university: 'HUTECH', total_credits: 125, non_accum_credits: 5});

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 2: TẠO TẤT CẢ NODE MÔN HỌC                           ║
// ╚══════════════════════════════════════════════════════════════╝

// ────────────────────────────────────────────────────────────────
// I. KIẾN THỨC GIÁO DỤC ĐẠI CƯƠNG (44 tín chỉ)
// ────────────────────────────────────────────────────────────────
MERGE (:Course {id: 'POS104', name: 'Triết học Mác - Lênin', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'POS105', name: 'Kinh tế chính trị Mác - Lênin', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS106', name: 'Chủ nghĩa xã hội khoa học', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS107', name: 'Lịch sử Đảng Cộng sản Việt Nam', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS103', name: 'Tư tưởng Hồ Chí Minh', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'ENC120', name: 'Anh ngữ 1', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC121', name: 'Anh ngữ 2', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC122', name: 'Anh ngữ 3', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC123', name: 'Anh ngữ 4', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'AIT129', name: 'Trí tuệ nhân tạo ứng dụng', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENS192', name: 'Phát triển bền vững', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'LAW106', name: 'Pháp luật đại cương', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'SKL115', name: 'Tư duy thiết kế dự án', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'SKL101', name: 'Khởi nghiệp', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'MAN116', name: 'Quản trị học', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'MAT124', name: 'Toán ứng dụng trong kinh tế', credits: 3, category: 'Đại cương'});

// ────────────────────────────────────────────────────────────────
// II.1. KIẾN THỨC CHUYÊN NGHIỆP BẮT BUỘC (72 tín chỉ)
// ────────────────────────────────────────────────────────────────
MERGE (:Course {id: 'ECO149', name: 'Kinh tế học đại cương', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'BUS170', name: 'Thống kê trong kinh tế và kinh doanh', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAR146', name: 'Nguyên lý marketing', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAR1003', name: 'Ngân sách marketing', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAR1005', name: 'Hành vi tiêu dùng trong kỷ nguyên số', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAR136', name: 'Đạo đức và trách nhiệm xã hội trong marketing', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAR251', name: 'Digital marketing', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAR1007', name: 'Sáng tạo và thiết kế sản phẩm mới', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAR130', name: 'Marketing dịch vụ', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAR112', name: 'Thiết lập hệ thống kênh phân phối', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAN122', name: 'Quản trị marketing', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAR148', name: 'Bán hàng và chăm sóc khách hàng', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAR154', name: 'Truyền thông marketing', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAR120', name: 'Marketing quốc tế', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAR117', name: 'Nghiên cứu marketing', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'BUS2008', name: 'Phương pháp nghiên cứu khoa học trong kinh doanh', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAN2094', name: 'Quản lý mối quan hệ khách hàng', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ENG1008', name: 'Tiếng Anh chuyên ngành Marketing', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAR1012', name: 'Định giá sản phẩm', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAR2004', name: 'Ứng dụng công nghệ trong marketing', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAR5013', name: 'Thực tế doanh nghiệp ngành Marketing', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAN130', name: 'Quản trị thương hiệu', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAR155', name: 'Quảng cáo', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAR531', name: 'Thực tập tốt nghiệp ngành Marketing', credits: 3, category: 'Chuyên nghiệp bắt buộc'});

// ────────────────────────────────────────────────────────────────
// II.2. KIẾN THỨC TỰ CHỌN (chọn 9 tín chỉ)
// ────────────────────────────────────────────────────────────────

// Nhóm 1: Marketing trên nền tảng số
MERGE (:Course {id: 'MAR4014', name: 'Đồ án digital marketing', credits: 3, category: 'Tự chọn - Marketing trên nền tảng số'});
MERGE (:Course {id: 'MAR252', name: 'Content marketing', credits: 3, category: 'Tự chọn - Marketing trên nền tảng số'});
MERGE (:Course {id: 'MAR1006', name: 'Marketing mạng xã hội', credits: 3, category: 'Tự chọn - Marketing trên nền tảng số'});

// Nhóm 2: Quan hệ công chúng và tổ chức sự kiện
MERGE (:Course {id: 'EVT4001', name: 'Đồ án quan hệ công chúng và tổ chức sự kiện', credits: 3, category: 'Tự chọn - Quan hệ công chúng và tổ chức sự kiện'});
MERGE (:Course {id: 'EVT2002', name: 'Quản trị tổ chức sự kiện', credits: 3, category: 'Tự chọn - Quan hệ công chúng và tổ chức sự kiện'});
MERGE (:Course {id: 'MAR115', name: 'Quan hệ công chúng', credits: 3, category: 'Tự chọn - Quan hệ công chúng và tổ chức sự kiện'});

// Nhóm 3: Phân tích dữ liệu trong marketing
MERGE (:Course {id: 'MAR4015', name: 'Đồ án phân tích dữ liệu trong marketing', credits: 3, category: 'Tự chọn - Phân tích dữ liệu trong marketing'});
MERGE (:Course {id: 'MAR2016', name: 'Marketing analytics', credits: 3, category: 'Tự chọn - Phân tích dữ liệu trong marketing'});
MERGE (:Course {id: 'MAR169', name: 'Phân tích digital marketing ứng dụng', credits: 3, category: 'Tự chọn - Phân tích dữ liệu trong marketing'});

// Nhóm 4: Khóa luận tốt nghiệp
MERGE (:Course {id: 'MAR421', name: 'Khóa luận tốt nghiệp Marketing', credits: 9, category: 'Tự chọn - Khóa luận tốt nghiệp'});

// ────────────────────────────────────────────────────────────────
// III. KIẾN THỨC KHÔNG TÍCH LŨY
// ────────────────────────────────────────────────────────────────

// III.1. Giáo dục thể chất (5 tín chỉ)
MERGE (:Course {id: 'PHT304', name: 'Bóng chuyền 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT305', name: 'Bóng chuyền 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT306', name: 'Bóng chuyền 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT307', name: 'Bóng rổ 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT308', name: 'Bóng rổ 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT309', name: 'Bóng rổ 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT310', name: 'Thể hình - Thẩm mỹ 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT311', name: 'Thể hình - Thẩm mỹ 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT312', name: 'Thể hình - Thẩm mỹ 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT313', name: 'Vovinam 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT314', name: 'Vovinam 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT315', name: 'Vovinam 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT316', name: 'Bóng đá 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT317', name: 'Bóng đá 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT318', name: 'Bóng đá 3', credits: 1, category: 'Thể chất'});

// III.2. Giáo dục Quốc phòng và An ninh
MERGE (:Course {id: 'NDF108', name: 'Quốc phòng, an ninh 1', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF109', name: 'Quốc phòng, an ninh 2', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF210', name: 'Quốc phòng, an ninh 3', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF211', name: 'Quốc phòng, an ninh 4', credits: 0, category: 'Quốc phòng An ninh'});

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 3: LIÊN KẾT MÔN HỌC VỚI NGÀNH                        ║
// ╚══════════════════════════════════════════════════════════════╝
MATCH (c:Course), (m:Major {id: '7340115'})
MERGE (c)-[:BELONGS_TO]->(m);

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 4: MÔN TIÊN QUYẾT (PREREQUISITE_FOR)                  ║
// ║  Chiều: (Môn phải học trước)-[:PREREQUISITE_FOR]->(Môn sau)  ║
// ╚══════════════════════════════════════════════════════════════╝

// --- Anh ngữ: chuỗi tiên quyết ---
MATCH (a:Course {id: 'ENC120'}), (b:Course {id: 'ENC121'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'ENC121'}), (b:Course {id: 'ENC122'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'ENC122'}), (b:Course {id: 'ENC123'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// --- Chuỗi Marketing (Cần Nguyên lý marketing - MAR146) ---
MATCH (p:Course {id: 'MAR146'})
WITH p
MATCH (c:Course) WHERE c.id IN ['MAR130', 'MAN122', 'MAR120', 'MAR5013', 'MAN130']
MERGE (p)-[:PREREQUISITE_FOR]->(c);

// --- Digital Marketing ---
MATCH (a:Course {id: 'MAR251'}), (b:Course {id: 'MAR169'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);


// === NGANH 3/18: 3.Quản lý xây dựng K25_Cypher.txt ===
// =============================================================================
// CHƯƠNG TRÌNH ĐÀO TẠO NGÀNH QUẢN LÝ XÂY DỰNG (7580302) - ĐẠI HỌC HUTECH
// Đối tượng áp dụng: Đại học hệ chính quy từ khóa tuyển sinh năm 2025
// Tổng khối lượng: 150 tín chỉ tích lũy + 5 tín chỉ không tích lũy
// =============================================================================

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 0: XÓA DỮ LIỆU CŨ (chạy 1 lần trước khi import)    ║
// ╚══════════════════════════════════════════════════════════════╝

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 1: TẠO NODE NGÀNH                                     ║
// ╚══════════════════════════════════════════════════════════════╝
MERGE (:Major {id: '7580302', name: 'Quản lý xây dựng', university: 'HUTECH', total_credits: 150, non_accum_credits: 5});

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 2: TẠO TẤT CẢ NODE MÔN HỌC                           ║
// ╚══════════════════════════════════════════════════════════════╝

// ────────────────────────────────────────────────────────────────
// I. KIẾN THỨC GIÁO DỤC ĐẠI CƯƠNG (50 tín chỉ)
// ────────────────────────────────────────────────────────────────
MERGE (:Course {id: 'POS104', name: 'Triết học Mác - Lênin', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'POS105', name: 'Kinh tế chính trị Mác - Lênin', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS106', name: 'Chủ nghĩa xã hội khoa học', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS107', name: 'Lịch sử Đảng Cộng sản Việt Nam', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS103', name: 'Tư tưởng Hồ Chí Minh', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'ENC120', name: 'Anh ngữ 1', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC121', name: 'Anh ngữ 2', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC122', name: 'Anh ngữ 3', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC123', name: 'Anh ngữ 4', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'AIT129', name: 'Trí tuệ nhân tạo ứng dụng', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENS192', name: 'Phát triển bền vững', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'LAW106', name: 'Pháp luật đại cương', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'SKL115', name: 'Tư duy thiết kế dự án', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'SKL116', name: 'Đổi mới sáng tạo và tư duy khởi nghiệp', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'MAT101', name: 'Đại số tuyến tính', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'MAT118', name: 'Giải tích', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'SKL122', name: 'Kỹ năng phát triển bản thân', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'CET183', name: 'Công tác kỹ sư ngành Quản lý xây dựng', credits: 3, category: 'Đại cương'});

// ────────────────────────────────────────────────────────────────
// II.1. KIẾN THỨC CHUYÊN NGHIỆP BẮT BUỘC (88 tín chỉ)
// ────────────────────────────────────────────────────────────────
MERGE (:Course {id: 'CET2037', name: 'Vẽ kỹ thuật xây dựng', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CET284', name: 'Mô hình thông tin công trình', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MET1003', name: 'Cơ học xây dựng', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CET133', name: 'Vật liệu xây dựng', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ARH1001', name: 'Kiến trúc công trình', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CET109', name: 'Kết cấu công trình', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CET104', name: 'Hệ thống kỹ thuật công trình', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CET1031', name: 'Hạ tầng đô thị', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CET1014', name: 'Công trình xanh', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CET114', name: 'Kỹ thuật thi công', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CET130', name: 'Tổ chức thi công', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ENS1001', name: 'Sức khỏe, an toàn, môi trường', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CET2039', name: 'Thống kê ứng dụng trong xây dựng', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CET278', name: 'Dự toán công trình', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ACC114', name: 'Nguyên lý kế toán', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAN1128', name: 'Quản trị và phát triển bất động sản', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ECO102', name: 'Đấu thầu trong hoạt động xây dựng', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'LAW1010', name: 'Luật và hợp đồng trong xây dựng', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FIN103', name: 'Lập và thẩm định dự án đầu tư xây dựng', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAN105', name: 'Quản lý dự án xây dựng', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAN109', name: 'Quản lý và tổ chức khai thác công trình', credits: 3, category: 'Chuyên nghiệp bắt buộc'});

// Đồ án và Thực tập
MERGE (:Course {id: 'CET4032', name: 'Đồ án mô hình thông tin công trình', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CET4017', name: 'Đồ án thi công', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CET4033', name: 'Đồ án dự toán công trình', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CET4034', name: 'Đồ án lập dự án đầu tư xây dựng', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ENS5002', name: 'Thực tập sức khỏe, an toàn, môi trường', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CET5035', name: 'Thực tập đấu thầu trong xây dựng', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAN5129', name: 'Thực tế doanh nghiệp ngành Quản lý xây dựng', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAN574', name: 'Thực tập tốt nghiệp ngành Quản lý xây dựng', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAN444', name: 'Đồ án tốt nghiệp Quản lý xây dựng', credits: 9, category: 'Chuyên nghiệp bắt buộc'});

// ────────────────────────────────────────────────────────────────
// II.2. KIẾN THỨC TỰ CHỌN (chọn 12 tín chỉ)
// ────────────────────────────────────────────────────────────────

// Nhóm 1: Quản lý dự án xây dựng
MERGE (:Course {id: 'MAN1130', name: 'Quản trị nguồn nhân lực trong xây dựng', credits: 3, category: 'Tự chọn - Quản lý dự án xây dựng'});
MERGE (:Course {id: 'MAN145', name: 'Quản lý chất lượng công trình xây dựng', credits: 3, category: 'Tự chọn - Quản lý dự án xây dựng'});
MERGE (:Course {id: 'MAN248', name: 'Quản lý tiến độ dự án xây dựng', credits: 3, category: 'Tự chọn - Quản lý dự án xây dựng'});
MERGE (:Course {id: 'FIN1015', name: 'Quản lý chi phí dự án xây dựng', credits: 3, category: 'Tự chọn - Quản lý dự án xây dựng'});

// Nhóm 2: Quản trị doanh nghiệp xây dựng
MERGE (:Course {id: 'ACC1001', name: 'Kế toán trong doanh nghiệp xây dựng', credits: 3, category: 'Tự chọn - Quản trị doanh nghiệp xây dựng'});
MERGE (:Course {id: 'MAR1018', name: 'Marketing trong hoạt động xây dựng', credits: 3, category: 'Tự chọn - Quản trị doanh nghiệp xây dựng'});
MERGE (:Course {id: 'LAW1011', name: 'Pháp lý và đạo đức trong kinh doanh xây dựng', credits: 3, category: 'Tự chọn - Quản trị doanh nghiệp xây dựng'});
MERGE (:Course {id: 'MAN1131', name: 'Quản lý rủi ro trong doanh nghiệp xây dựng', credits: 3, category: 'Tự chọn - Quản trị doanh nghiệp xây dựng'});

// ────────────────────────────────────────────────────────────────
// III. KIẾN THỨC KHÔNG TÍCH LŨY
// ────────────────────────────────────────────────────────────────

// III.1. Giáo dục thể chất (5 tín chỉ)
// Nhóm 1: Bóng chuyền
MERGE (:Course {id: 'PHT304', name: 'Bóng chuyền 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT305', name: 'Bóng chuyền 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT306', name: 'Bóng chuyền 3', credits: 1, category: 'Thể chất'});
// Nhóm 2: Bóng rổ
MERGE (:Course {id: 'PHT307', name: 'Bóng rổ 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT308', name: 'Bóng rổ 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT309', name: 'Bóng rổ 3', credits: 1, category: 'Thể chất'});
// Nhóm 3: Thể hình - Thẩm mỹ
MERGE (:Course {id: 'PHT310', name: 'Thể hình - Thẩm mỹ 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT311', name: 'Thể hình - Thẩm mỹ 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT312', name: 'Thể hình - Thẩm mỹ 3', credits: 1, category: 'Thể chất'});
// Nhóm 4: Vovinam
MERGE (:Course {id: 'PHT313', name: 'Vovinam 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT314', name: 'Vovinam 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT315', name: 'Vovinam 3', credits: 1, category: 'Thể chất'});
// Nhóm 5: Bóng đá
MERGE (:Course {id: 'PHT316', name: 'Bóng đá 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT317', name: 'Bóng đá 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT318', name: 'Bóng đá 3', credits: 1, category: 'Thể chất'});

// III.2. Giáo dục Quốc phòng và An ninh
MERGE (:Course {id: 'NDF108', name: 'Quốc phòng, an ninh 1', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF109', name: 'Quốc phòng, an ninh 2', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF210', name: 'Quốc phòng, an ninh 3', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF211', name: 'Quốc phòng, an ninh 4', credits: 0, category: 'Quốc phòng An ninh'});

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 3: LIÊN KẾT MÔN HỌC VỚI NGÀNH                        ║
// ╚══════════════════════════════════════════════════════════════╝
MATCH (c:Course), (m:Major {id: '7580302'})
WHERE c.id IN [
    'POS104', 'POS105', 'POS106', 'POS107', 'POS103', 'ENC120', 'ENC121', 'ENC122',
    'ENC123', 'AIT129', 'ENS192', 'LAW106', 'SKL115', 'SKL116', 'MAT101', 'MAT118',
    'SKL122', 'CET183', 'CET2037', 'CET284', 'MET1003', 'CET133', 'ARH1001', 'CET109',
    'CET104', 'CET1031', 'CET1014', 'CET114', 'CET130', 'ENS1001', 'CET2039', 'CET278',
    'ACC114', 'MAN1128', 'ECO102', 'LAW1010', 'FIN103', 'MAN105', 'MAN109', 'CET4032',
    'CET4017', 'CET4033', 'CET4034', 'ENS5002', 'CET5035', 'MAN5129', 'MAN574', 'MAN444',
    'MAN1130', 'MAN145', 'MAN248', 'FIN1015', 'ACC1001', 'MAR1018', 'LAW1011', 'MAN1131',
    'PHT304', 'PHT305', 'PHT306', 'PHT307', 'PHT308', 'PHT309', 'PHT310', 'PHT311',
    'PHT312', 'PHT313', 'PHT314', 'PHT315', 'PHT316', 'PHT317', 'PHT318', 'NDF108',
    'NDF109', 'NDF210', 'NDF211'
]
MERGE (c)-[:BELONGS_TO]->(m);

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 4: MÔN TIÊN QUYẾT (PREREQUISITE_FOR)                  ║
// ║  Chiều: (Môn phải học trước)-[:PREREQUISITE_FOR]->(Môn sau)  ║
// ╚══════════════════════════════════════════════════════════════╝

// --- Anh ngữ: chuỗi tiên quyết ---
MATCH (a:Course {id: 'ENC120'}), (b:Course {id: 'ENC121'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'ENC121'}), (b:Course {id: 'ENC122'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'ENC122'}), (b:Course {id: 'ENC123'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// --- Kỹ năng ---
MATCH (a:Course {id: 'SKL115'}), (b:Course {id: 'SKL116'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// --- Chuyên ngành ---
MATCH (a:Course {id: 'CET114'}), (b:Course {id: 'CET278'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'CET114'}), (b:Course {id: 'CET4017'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'ENS1001'}), (b:Course {id: 'ENS5002'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 5: MÔN SONG HÀNH (COREQUISITE_WITH)                   ║
// ║  Thực hành/Đồ án đi đôi với lý thuyết                        ║
// ╚══════════════════════════════════════════════════════════════╝

MATCH (a:Course {id: 'CET4032'}), (b:Course {id: 'CET284'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'CET4033'}), (b:Course {id: 'CET278'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'CET4034'}), (b:Course {id: 'FIN103'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'CET5035'}), (b:Course {id: 'ECO102'}) MERGE (a)-[:COREQUISITE_WITH]->(b);


// === NGANH 4/18: 4.Quản trị sự kiện K25_Cypher.txt ===
// =============================================================================
// CHƯƠNG TRÌNH ĐÀO TẠO NGÀNH QUẢN TRỊ SỰ KIỆN (7340412) - ĐẠI HỌC HUTECH
// Đối tượng áp dụng: Đại học hệ chính quy từ khóa tuyển sinh năm 2025
// Tổng khối lượng: 125 tín chỉ tích lũy + 5 tín chỉ không tích lũy
// =============================================================================

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 0: XÓA DỮ LIỆU CŨ (chạy 1 lần trước khi import)    ║
// ╚══════════════════════════════════════════════════════════════╝

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 1: TẠO NODE NGÀNH                                     ║
// ╚══════════════════════════════════════════════════════════════╝
MERGE (:Major {id: '7340412', name: 'Quản trị sự kiện', university: 'HUTECH', total_credits: 125, non_accum_credits: 5});

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 2: TẠO TẤT CẢ NODE MÔN HỌC                           ║
// ╚══════════════════════════════════════════════════════════════╝

// ────────────────────────────────────────────────────────────────
// I. KIẾN THỨC GIÁO DỤC ĐẠI CƯƠNG (44 tín chỉ)
// ────────────────────────────────────────────────────────────────
MERGE (:Course {id: 'POS104', name: 'Triết học Mác - Lênin', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'POS105', name: 'Kinh tế chính trị Mác - Lênin', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS106', name: 'Chủ nghĩa xã hội khoa học', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS107', name: 'Lịch sử Đảng Cộng sản Việt Nam', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS103', name: 'Tư tưởng Hồ Chí Minh', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'ENC120', name: 'Anh ngữ 1', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC121', name: 'Anh ngữ 2', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC122', name: 'Anh ngữ 3', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC123', name: 'Anh ngữ 4', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'AIT129', name: 'Trí tuệ nhân tạo ứng dụng', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENS192', name: 'Phát triển bền vững', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'LAW158', name: 'Luật và Khởi nghiệp', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'SKL115', name: 'Tư duy thiết kế dự án', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'MAN116', name: 'Quản trị học', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'SOS101', name: 'Cơ sở văn hóa Việt Nam', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'SKL122', name: 'Kỹ năng phát triển bản thân', credits: 3, category: 'Đại cương'});

// ────────────────────────────────────────────────────────────────
// II.1. KIẾN THỨC CHUYÊN NGHIỆP BẮT BUỘC (72 tín chỉ)
// ────────────────────────────────────────────────────────────────
MERGE (:Course {id: 'MAN1051', name: 'Tổng quan về lĩnh vực sự kiện và giải trí', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'EVT103', name: 'Nghiệp vụ tổ chức sự kiện 1', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'EVT1003', name: 'Thiết kế ấn phẩm truyền thông sự kiện', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAR149', name: 'Marketing và truyền thông trong sự kiện', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'EVT108', name: 'Nghiệp vụ gây quỹ tài trợ', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'EVT106', name: 'Soạn thảo văn bản sự kiện', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'EVT1004', name: 'Quay và dựng video trong sự kiện', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'HMM141', name: 'Điều hành hội nghị và yến tiệc', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'EVT1013', name: 'Nghệ thuật nói chuyện trước công chúng', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'EVT115', name: 'Biên tập chương trình sự kiện', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'EVT1005', name: 'Đạo diễn chương trình sự kiện', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAN1074', name: 'Quản trị nguồn nhân lực trong sự kiện', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'EVT109', name: 'Ứng dụng công nghệ trong sự kiện', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAN1075', name: 'Quản trị rủi ro sự kiện', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'EVT111', name: 'Phương pháp viết đề án trong tổ chức sự kiện', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'EVT110', name: 'Tổ chức sản xuất sự kiện', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'LAW189', name: 'Quy định pháp luật về tổ chức sự kiện', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'EVT1006', name: 'Quản trị đám đông trong tổ chức sự kiện', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'EVT104', name: 'Nghiệp vụ tổ chức sự kiện 2', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'EVT701', name: 'Kiến tập tổ chức sự kiện 1', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'EVT702', name: 'Kiến tập tổ chức sự kiện 2', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAN1078', name: 'Quản trị chiến lược trong tổ chức dịch vụ giải trí', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'TOU341', name: 'Hoạt náo', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'TOU102', name: 'Dịch vụ chăm sóc khách hàng', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'EVT1008', name: 'Thiết kế sân khấu trong sự kiện', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'EVT513', name: 'Thực tập tốt nghiệp ngành Quản trị sự kiện', credits: 3, category: 'Chuyên nghiệp bắt buộc'});

// ────────────────────────────────────────────────────────────────
// II.2. KIẾN THỨC TỰ CHỌN (chọn 9 tín chỉ)
// ────────────────────────────────────────────────────────────────

// Nhóm 1: Sự kiện văn hóa và thể thao
MERGE (:Course {id: 'EVT1009', name: 'Sự kiện văn hóa và nghệ thuật', credits: 3, category: 'Tự chọn - Sự kiện văn hóa và thể thao'});
MERGE (:Course {id: 'EVT1010', name: 'Quản lý nghệ sĩ trong tổ chức sự kiện', credits: 3, category: 'Tự chọn - Sự kiện văn hóa và thể thao'});
MERGE (:Course {id: 'EVT114', name: 'Tổ chức sự kiện thể thao', credits: 3, category: 'Tự chọn - Sự kiện văn hóa và thể thao'});

// Nhóm 2: Sự kiện marketing - MICE
MERGE (:Course {id: 'TOU1009', name: 'Quản trị MICE', credits: 3, category: 'Tự chọn - Sự kiện marketing - MICE'});
MERGE (:Course {id: 'MAN1080', name: 'Quản trị sự kiện trong ngành du lịch', credits: 3, category: 'Tự chọn - Sự kiện marketing - MICE'});
MERGE (:Course {id: 'EVT1011', name: 'Tổ chức sự kiện marketing', credits: 3, category: 'Tự chọn - Sự kiện marketing - MICE'});

// Nhóm 3: Khóa luận tốt nghiệp
MERGE (:Course {id: 'EVT4012', name: 'Khóa luận tốt nghiệp Quản trị sự kiện', credits: 9, category: 'Tự chọn - Khóa luận tốt nghiệp'});

// ────────────────────────────────────────────────────────────────
// III. KIẾN THỨC KHÔNG TÍCH LŨY
// ────────────────────────────────────────────────────────────────

// III.1. Giáo dục thể chất (5 tín chỉ)
// Nhóm 1: Bóng chuyền
MERGE (:Course {id: 'PHT304', name: 'Bóng chuyền 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT305', name: 'Bóng chuyền 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT306', name: 'Bóng chuyền 3', credits: 1, category: 'Thể chất'});
// Nhóm 2: Bóng rổ
MERGE (:Course {id: 'PHT307', name: 'Bóng rổ 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT308', name: 'Bóng rổ 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT309', name: 'Bóng rổ 3', credits: 1, category: 'Thể chất'});
// Nhóm 3: Thể hình - Thẩm mỹ
MERGE (:Course {id: 'PHT310', name: 'Thể hình - Thẩm mỹ 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT311', name: 'Thể hình - Thẩm mỹ 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT312', name: 'Thể hình - Thẩm mỹ 3', credits: 1, category: 'Thể chất'});
// Nhóm 4: Vovinam
MERGE (:Course {id: 'PHT313', name: 'Vovinam 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT314', name: 'Vovinam 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT315', name: 'Vovinam 3', credits: 1, category: 'Thể chất'});
// Nhóm 5: Bóng đá
MERGE (:Course {id: 'PHT316', name: 'Bóng đá 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT317', name: 'Bóng đá 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT318', name: 'Bóng đá 3', credits: 1, category: 'Thể chất'});

// III.2. Giáo dục Quốc phòng và An ninh
MERGE (:Course {id: 'NDF108', name: 'Quốc phòng, an ninh 1', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF109', name: 'Quốc phòng, an ninh 2', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF210', name: 'Quốc phòng, an ninh 3', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF211', name: 'Quốc phòng, an ninh 4', credits: 0, category: 'Quốc phòng An ninh'});

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 3: LIÊN KẾT MÔN HỌC VỚI NGÀNH                        ║
// ╚══════════════════════════════════════════════════════════════╝
MATCH (c:Course), (m:Major {id: '7340412'})
WHERE c.id IN [
    'POS104', 'POS105', 'POS106', 'POS107', 'POS103', 'ENC120', 'ENC121', 'ENC122',
    'ENC123', 'AIT129', 'ENS192', 'LAW158', 'SKL115', 'MAN116', 'SOS101', 'SKL122',
    'MAN1051', 'EVT103', 'EVT1003', 'MAR149', 'EVT108', 'EVT106', 'EVT1004', 'HMM141',
    'EVT1013', 'EVT115', 'EVT1005', 'MAN1074', 'EVT109', 'MAN1075', 'EVT111', 'EVT110',
    'LAW189', 'EVT1006', 'EVT104', 'EVT701', 'EVT702', 'MAN1078', 'TOU341', 'TOU102',
    'EVT1008', 'EVT513', 'EVT1009', 'EVT1010', 'EVT114', 'TOU1009', 'MAN1080', 'EVT1011',
    'EVT4012', 'PHT304', 'PHT305', 'PHT306', 'PHT307', 'PHT308', 'PHT309', 'PHT310',
    'PHT311', 'PHT312', 'PHT313', 'PHT314', 'PHT315', 'PHT316', 'PHT317', 'PHT318',
    'NDF108', 'NDF109', 'NDF210', 'NDF211'
]
MERGE (c)-[:BELONGS_TO]->(m);

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 4: MÔN TIÊN QUYẾT (PREREQUISITE_FOR)                  ║
// ║  Chiều: (Môn phải học trước)-[:PREREQUISITE_FOR]->(Môn sau)  ║
// ╚══════════════════════════════════════════════════════════════╝

// --- Anh ngữ: chuỗi tiên quyết ---
MATCH (a:Course {id: 'ENC120'}), (b:Course {id: 'ENC121'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'ENC121'}), (b:Course {id: 'ENC122'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'ENC122'}), (b:Course {id: 'ENC123'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// --- Chuyên ngành ---
MATCH (a:Course {id: 'MAN1051'}), (b:Course {id: 'MAN1075'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'EVT108'}), (b:Course {id: 'EVT104'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'EVT1003'}), (b:Course {id: 'EVT1008'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);


// === NGANH 5/18: 5.Tâm lý học K25_Cypher.txt ===
// =============================================================================
// CHƯƠNG TRÌNH ĐÀO TẠO NGÀNH TÂM LÝ HỌC (7310401) - ĐẠI HỌC HUTECH
// Đối tượng áp dụng: Đại học hệ chính quy từ khóa tuyển sinh năm 2025
// Tổng khối lượng: 125 tín chỉ tích lũy + 5 tín chỉ không tích lũy
// =============================================================================

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 0: XÓA DỮ LIỆU CŨ (chạy 1 lần trước khi import)    ║
// ╚══════════════════════════════════════════════════════════════╝

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 1: TẠO NODE NGÀNH                                     ║
// ╚══════════════════════════════════════════════════════════════╝
MERGE (:Major {id: '7310401', name: 'Tâm lý học', university: 'HUTECH', total_credits: 125, non_accum_credits: 5});

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 2: TẠO TẤT CẢ NODE MÔN HỌC                           ║
// ╚══════════════════════════════════════════════════════════════╝

// ────────────────────────────────────────────────────────────────
// I. KIẾN THỨC GIÁO DỤC ĐẠI CƯƠNG (44 tín chỉ)
// ────────────────────────────────────────────────────────────────
MERGE (:Course {id: 'POS104', name: 'Triết học Mác - Lênin', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'POS105', name: 'Kinh tế chính trị Mác - Lênin', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS106', name: 'Chủ nghĩa xã hội khoa học', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS107', name: 'Lịch sử Đảng Cộng sản Việt Nam', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS103', name: 'Tư tưởng Hồ Chí Minh', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'ENC120', name: 'Anh ngữ 1', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC121', name: 'Anh ngữ 2', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC122', name: 'Anh ngữ 3', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC123', name: 'Anh ngữ 4', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'AIT129', name: 'Trí tuệ nhân tạo ứng dụng', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENS192', name: 'Phát triển bền vững', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'LAW158', name: 'Luật và Khởi nghiệp', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'SKL115', name: 'Tư duy thiết kế dự án', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'SOS101', name: 'Cơ sở văn hóa Việt Nam', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'SOS102', name: 'Xã hội học', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'SKL102', name: 'Kỹ năng thuyết trình và tìm việc', credits: 3, category: 'Đại cương'});

// ────────────────────────────────────────────────────────────────
// II.1. KIẾN THỨC CHUYÊN NGHIỆP BẮT BUỘC (72 tín chỉ)
// ────────────────────────────────────────────────────────────────
MERGE (:Course {id: 'PSY103', name: 'Giải phẫu và sinh lý hoạt động thần kinh cấp cao', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'PSY106', name: 'Tâm lý học đại cương', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'PSY108', name: 'Tâm lý học phát triển', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'PSY165', name: 'Phương pháp nghiên cứu tâm lý học', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'PSY205', name: 'Thống kê ứng dụng trong nghiên cứu tâm lý học', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'PSY111', name: 'Trắc nghiệm và chẩn đoán tâm lý', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'PSY109', name: 'Tâm lý học xã hội', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'PSY123', name: 'Tâm lý học giới tính', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'PSY114', name: 'Tâm lý học gia đình', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'PSY107', name: 'Tâm lý học nhân cách', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'PSY113', name: 'Tâm lý học giao tiếp', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'SKL109', name: 'Kỹ năng tham vấn tâm lý', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'PSY141', name: 'Tâm lý học thần kinh', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'PSY125', name: 'Tâm bệnh học', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'PSY1001', name: 'Tâm lý học truyền thông', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'PSY177', name: 'Lý thuyết tham vấn và trị liệu tâm lý', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'PSY146', name: 'Nhập môn tâm lý học lâm sàng', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'PSY117', name: 'Tâm lý học quản lý', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'PSY134', name: 'Tâm lý học tổ chức', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'PSY118', name: 'Tâm lý học quảng cáo - marketing', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'PSY170', name: 'Tâm lý giáo dục ứng dụng', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'PSY171', name: 'Tâm lý học cảm xúc', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'PSY126', name: 'Tâm lý học nhân sự', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'PSY549', name: 'Thực tập tốt nghiệp ngành Tâm lý học', credits: 3, category: 'Chuyên nghiệp bắt buộc'});

// ────────────────────────────────────────────────────────────────
// II.2. KIẾN THỨC TỰ CHỌN (chọn 9 tín chỉ)
// ────────────────────────────────────────────────────────────────

// Nhóm 1: Tham vấn
MERGE (:Course {id: 'PSY132', name: 'Tham vấn học đường', credits: 3, category: 'Tự chọn - Tham vấn'});
MERGE (:Course {id: 'PSY133', name: 'Tham vấn cộng đồng', credits: 3, category: 'Tự chọn - Tham vấn'});
MERGE (:Course {id: 'PSY157', name: 'Tham vấn tình yêu, hôn nhân và gia đình', credits: 3, category: 'Tự chọn - Tham vấn'});

// Nhóm 2: Trị liệu
MERGE (:Course {id: 'PSY174', name: 'Trị liệu tập trung vào cảm xúc', credits: 3, category: 'Tự chọn - Trị liệu'});
MERGE (:Course {id: 'PSY159', name: 'Trị liệu hệ thống', credits: 3, category: 'Tự chọn - Trị liệu'});
MERGE (:Course {id: 'PSY160', name: 'Trị liệu nhận thức hành vi', credits: 3, category: 'Tự chọn - Trị liệu'});

// Nhóm 3: Tổ chức nhân sự
MERGE (:Course {id: 'MAN1088', name: 'Nghiệp vụ quản trị văn phòng', credits: 3, category: 'Tự chọn - Tổ chức nhân sự'});
MERGE (:Course {id: 'MAN1089', name: 'Quản trị nguồn nhân lực trong tâm lý', credits: 3, category: 'Tự chọn - Tổ chức nhân sự'});
MERGE (:Course {id: 'PSY162', name: 'Tâm lý học tư vấn trong doanh nghiệp', credits: 3, category: 'Tự chọn - Tổ chức nhân sự'});

// Nhóm 4: Khóa luận tốt nghiệp
MERGE (:Course {id: 'PSY435', name: 'Khóa luận tốt nghiệp Tâm lý học', credits: 9, category: 'Tự chọn - Khóa luận tốt nghiệp'});

// ────────────────────────────────────────────────────────────────
// III. KIẾN THỨC KHÔNG TÍCH LŨY
// ────────────────────────────────────────────────────────────────

// III.1. Giáo dục thể chất (5 tín chỉ)
MERGE (:Course {id: 'PHT304', name: 'Bóng chuyền 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT305', name: 'Bóng chuyền 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT306', name: 'Bóng chuyền 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT307', name: 'Bóng rổ 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT308', name: 'Bóng rổ 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT309', name: 'Bóng rổ 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT310', name: 'Thể hình - Thẩm mỹ 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT311', name: 'Thể hình - Thẩm mỹ 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT312', name: 'Thể hình - Thẩm mỹ 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT313', name: 'Vovinam 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT314', name: 'Vovinam 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT315', name: 'Vovinam 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT316', name: 'Bóng đá 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT317', name: 'Bóng đá 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT318', name: 'Bóng đá 3', credits: 1, category: 'Thể chất'});

// III.2. Giáo dục Quốc phòng và An ninh
MERGE (:Course {id: 'NDF108', name: 'Quốc phòng, an ninh 1', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF109', name: 'Quốc phòng, an ninh 2', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF210', name: 'Quốc phòng, an ninh 3', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF211', name: 'Quốc phòng, an ninh 4', credits: 0, category: 'Quốc phòng An ninh'});

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 3: LIÊN KẾT MÔN HỌC VỚI NGÀNH                        ║
// ╚══════════════════════════════════════════════════════════════╝
MATCH (c:Course), (m:Major {id: '7310401'})
MERGE (c)-[:BELONGS_TO]->(m);

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 4: MÔN TIÊN QUYẾT (PREREQUISITE_FOR)                  ║
// ║  Chiều: (Môn phải học trước)-[:PREREQUISITE_FOR]->(Môn sau)  ║
// ╚══════════════════════════════════════════════════════════════╝

// --- Anh ngữ: chuỗi tiên quyết ---
MATCH (a:Course {id: 'ENC120'}), (b:Course {id: 'ENC121'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'ENC121'}), (b:Course {id: 'ENC122'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'ENC122'}), (b:Course {id: 'ENC123'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// --- Tâm lý học đại cương (PSY106) là nền tảng ---
MATCH (p:Course {id: 'PSY106'})
WITH p
MATCH (c:Course) WHERE c.id IN ['PSY111', 'PSY109', 'PSY123', 'PSY114', 'PSY107', 'PSY113', 'SKL109', 'PSY141', 'PSY117', 'PSY134', 'PSY118', 'PSY170', 'PSY171']
MERGE (p)-[:PREREQUISITE_FOR]->(c);

// --- Tâm lý học nhân cách (PSY107) là nền tảng ---
MATCH (p:Course {id: 'PSY107'})
WITH p
MATCH (c:Course) WHERE c.id IN ['PSY1001', 'PSY177', 'PSY146']
MERGE (p)-[:PREREQUISITE_FOR]->(c);


// === NGANH 6/18: 6.Thanh nhạc K25_Cypher.txt ===
// =============================================================================
// CHƯƠNG TRÌNH ĐÀO TẠO NGÀNH THANH NHẠC (7210205) - ĐẠI HỌC HUTECH
// Đối tượng áp dụng: Đại học hệ chính quy từ khóa tuyển sinh năm 2025
// Tổng khối lượng: 125 tín chỉ tích lũy + 5 tín chỉ không tích lũy
// =============================================================================

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 0: XÓA DỮ LIỆU CŨ (chạy 1 lần trước khi import)    ║
// ╚══════════════════════════════════════════════════════════════╝

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 1: TẠO NODE NGÀNH                                     ║
// ╚══════════════════════════════════════════════════════════════╝
MERGE (:Major {id: '7210205', name: 'Thanh nhạc', university: 'HUTECH', total_credits: 125, non_accum_credits: 5});

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 2: TẠO TẤT CẢ NODE MÔN HỌC                           ║
// ╚══════════════════════════════════════════════════════════════╝

// ────────────────────────────────────────────────────────────────
// I. KIẾN THỨC GIÁO DỤC ĐẠI CƯƠNG (44 tín chỉ)
// ────────────────────────────────────────────────────────────────
MERGE (:Course {id: 'POS104', name: 'Triết học Mác - Lênin', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'POS105', name: 'Kinh tế chính trị Mác - Lênin', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS106', name: 'Chủ nghĩa xã hội khoa học', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS107', name: 'Lịch sử Đảng Cộng sản Việt Nam', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS103', name: 'Tư tưởng Hồ Chí Minh', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'ENC120', name: 'Anh ngữ 1', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC121', name: 'Anh ngữ 2', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC122', name: 'Anh ngữ 3', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC123', name: 'Anh ngữ 4', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'AIT129', name: 'Trí tuệ nhân tạo ứng dụng', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENS192', name: 'Phát triển bền vững', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'LAW158', name: 'Luật và Khởi nghiệp', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'SKL115', name: 'Tư duy thiết kế dự án', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'SOS101', name: 'Cơ sở văn hóa Việt Nam', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'SOS103', name: 'Lịch sử văn minh thế giới', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'PSY140', name: 'Giáo dục cảm xúc', credits: 3, category: 'Đại cương'});

// ────────────────────────────────────────────────────────────────
// II.1. KIẾN THỨC CHUYÊN NGHIỆP BẮT BUỘC (72 tín chỉ)
// ────────────────────────────────────────────────────────────────
MERGE (:Course {id: 'MUS1004', name: 'Phân tích âm nhạc', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MUS201', name: 'Ký xướng âm 1', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MUS203', name: 'Ký xướng âm 2', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MUS204', name: 'Ký xướng âm 3', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MUS1005', name: 'Lịch sử âm nhạc', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MUS134', name: 'Nhạc lý', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MUS119', name: 'Hòa âm', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MUS202', name: 'Thanh nhạc 1', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MUS205', name: 'Thanh nhạc 2', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MUS206', name: 'Thanh nhạc 3', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MUS207', name: 'Thanh nhạc 4', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MUS208', name: 'Thanh nhạc 5', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MUS209', name: 'Thanh nhạc 6', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MUS2006', name: 'Kỹ năng sư phạm âm nhạc', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MUS2001', name: 'Piano căn bản', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MUS2002', name: 'Piano nâng cao', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MUS2003', name: 'Piano đệm hát', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MUS236', name: 'Kỹ thuật thu âm', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MUS2007', name: 'Ứng dụng công nghệ trong soạn nhạc', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MUS2008', name: 'Vũ đạo sân khấu 1', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MUS2009', name: 'Vũ đạo sân khấu 2', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MUS2010', name: 'Kỹ thuật sáng tác ca khúc', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MUS2011', name: 'Biên tập và dàn dựng chương trình văn hóa nghệ thuật', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MUS526', name: 'Thực tập tốt nghiệp ngành Thanh nhạc', credits: 3, category: 'Chuyên nghiệp bắt buộc'});

// ────────────────────────────────────────────────────────────────
// II.2. KIẾN THỨC TỰ CHỌN (chọn 9 tín chỉ)
// ────────────────────────────────────────────────────────────────

// Nhóm 1: Biểu diễn chuyên ngành
MERGE (:Course {id: 'MUS2012', name: 'Biểu diễn thanh nhạc trên sân khấu', credits: 3, category: 'Tự chọn - Biểu diễn chuyên ngành'});
MERGE (:Course {id: 'MUS2013', name: 'Phong cách trình diễn và phát triển cá tính nghệ thuật', credits: 3, category: 'Tự chọn - Biểu diễn chuyên ngành'});
MERGE (:Course {id: 'MUS2014', name: 'Dự án biểu diễn cá nhân', credits: 3, category: 'Tự chọn - Biểu diễn chuyên ngành'});

// Nhóm 2: Thu âm và sản xuất âm nhạc
MERGE (:Course {id: 'MUS2015', name: 'Thu âm và xử lý hậu kỳ giọng hát', credits: 3, category: 'Tự chọn - Thu âm và sản xuất âm nhạc'});
MERGE (:Course {id: 'MUS2016', name: 'Ứng dụng công nghệ âm nhạc số', credits: 3, category: 'Tự chọn - Thu âm và sản xuất âm nhạc'});
MERGE (:Course {id: 'MUS2017', name: 'Dự án sản xuất sản phẩm âm nhạc cá nhân', credits: 3, category: 'Tự chọn - Thu âm và sản xuất âm nhạc'});

// Nhóm 3: Đồ án tốt nghiệp
MERGE (:Course {id: 'MUS4018', name: 'Đồ án tốt nghiệp Thanh nhạc', credits: 9, category: 'Tự chọn - Đồ án tốt nghiệp'});

// ────────────────────────────────────────────────────────────────
// III. KIẾN THỨC KHÔNG TÍCH LŨY
// ────────────────────────────────────────────────────────────────

// III.1. Giáo dục thể chất (5 tín chỉ)
MERGE (:Course {id: 'PHT304', name: 'Bóng chuyền 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT305', name: 'Bóng chuyền 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT306', name: 'Bóng chuyền 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT307', name: 'Bóng rổ 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT308', name: 'Bóng rổ 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT309', name: 'Bóng rổ 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT310', name: 'Thể hình - Thẩm mỹ 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT311', name: 'Thể hình - Thẩm mỹ 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT312', name: 'Thể hình - Thẩm mỹ 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT313', name: 'Vovinam 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT314', name: 'Vovinam 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT315', name: 'Vovinam 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT316', name: 'Bóng đá 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT317', name: 'Bóng đá 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT318', name: 'Bóng đá 3', credits: 1, category: 'Thể chất'});

// III.2. Giáo dục Quốc phòng và An ninh
MERGE (:Course {id: 'NDF108', name: 'Quốc phòng, an ninh 1', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF109', name: 'Quốc phòng, an ninh 2', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF210', name: 'Quốc phòng, an ninh 3', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF211', name: 'Quốc phòng, an ninh 4', credits: 0, category: 'Quốc phòng An ninh'});

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 3: LIÊN KẾT MÔN HỌC VỚI NGÀNH                        ║
// ╚══════════════════════════════════════════════════════════════╝
MATCH (c:Course), (m:Major {id: '7210205'})
WHERE c.id IN [
    'POS104', 'POS105', 'POS106', 'POS107', 'POS103', 'ENC120', 'ENC121', 'ENC122',
    'ENC123', 'AIT129', 'ENS192', 'LAW158', 'SKL115', 'SOS101', 'SOS103', 'PSY140',
    'MUS1004', 'MUS201', 'MUS203', 'MUS204', 'MUS1005', 'MUS134', 'MUS119', 'MUS202',
    'MUS205', 'MUS206', 'MUS207', 'MUS208', 'MUS209', 'MUS2006', 'MUS2001', 'MUS2002',
    'MUS2003', 'MUS236', 'MUS2007', 'MUS2008', 'MUS2009', 'MUS2010', 'MUS2011', 'MUS526',
    'MUS2012', 'MUS2013', 'MUS2014', 'MUS2015', 'MUS2016', 'MUS2017', 'MUS4018', 'PHT304',
    'PHT305', 'PHT306', 'PHT307', 'PHT308', 'PHT309', 'PHT310', 'PHT311', 'PHT312',
    'PHT313', 'PHT314', 'PHT315', 'PHT316', 'PHT317', 'PHT318', 'NDF108', 'NDF109',
    'NDF210', 'NDF211'
]
MERGE (c)-[:BELONGS_TO]->(m);

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 4: MÔN TIÊN QUYẾT (PREREQUISITE_FOR)                  ║
// ║  Chiều: (Môn phải học trước)-[:PREREQUISITE_FOR]->(Môn sau)  ║
// ╚══════════════════════════════════════════════════════════════╝

// --- Anh ngữ: chuỗi tiên quyết ---
MATCH (a:Course {id: 'ENC120'}), (b:Course {id: 'ENC121'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'ENC121'}), (b:Course {id: 'ENC122'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'ENC122'}), (b:Course {id: 'ENC123'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// --- Chuỗi Ký xướng âm ---
MATCH (a:Course {id: 'MUS201'}), (b:Course {id: 'MUS203'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'MUS203'}), (b:Course {id: 'MUS204'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// --- Chuỗi Thanh nhạc ---
MATCH (a:Course {id: 'MUS202'}), (b:Course {id: 'MUS205'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'MUS205'}), (b:Course {id: 'MUS206'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'MUS206'}), (b:Course {id: 'MUS207'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'MUS207'}), (b:Course {id: 'MUS208'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'MUS208'}), (b:Course {id: 'MUS209'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// --- Piano ---
MATCH (a:Course {id: 'MUS2001'}), (b:Course {id: 'MUS2002'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);


// === NGANH 7/18: 7.Thiết kế thời trang K25_Cypher.txt ===
// =============================================================================
// CHƯƠNG TRÌNH ĐÀO TẠO NGÀNH THIẾT KẾ THỜI TRANG (7210404) - ĐẠI HỌC HUTECH
// Đối tượng áp dụng: Đại học hệ chính quy từ khóa tuyển sinh năm 2025
// Tổng khối lượng: 125 tín chỉ tích lũy + 5 tín chỉ không tích lũy
// =============================================================================

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 0: XÓA DỮ LIỆU CŨ (chạy 1 lần trước khi import)    ║
// ╚══════════════════════════════════════════════════════════════╝

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 1: TẠO NODE NGÀNH                                     ║
// ╚══════════════════════════════════════════════════════════════╝
MERGE (:Major {id: '7210404', name: 'Thiết kế thời trang', university: 'HUTECH', total_credits: 125, non_accum_credits: 5});

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 2: TẠO TẤT CẢ NODE MÔN HỌC                           ║
// ╚══════════════════════════════════════════════════════════════╝

// ────────────────────────────────────────────────────────────────
// I. KIẾN THỨC GIÁO DỤC ĐẠI CƯƠNG (44 tín chỉ)
// ────────────────────────────────────────────────────────────────
MERGE (:Course {id: 'POS104', name: 'Triết học Mác - Lênin', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'POS105', name: 'Kinh tế chính trị Mác - Lênin', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS106', name: 'Chủ nghĩa xã hội khoa học', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS107', name: 'Lịch sử Đảng Cộng sản Việt Nam', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS103', name: 'Tư tưởng Hồ Chí Minh', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'ENC120', name: 'Anh ngữ 1', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC121', name: 'Anh ngữ 2', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC122', name: 'Anh ngữ 3', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC123', name: 'Anh ngữ 4', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'AIT129', name: 'Trí tuệ nhân tạo ứng dụng', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENS192', name: 'Phát triển bền vững', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'LAW106', name: 'Pháp luật đại cương', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'SKL115', name: 'Tư duy thiết kế dự án', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'SKL116', name: 'Đổi mới sáng tạo và tư duy khởi nghiệp', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'SOS101', name: 'Cơ sở văn hóa Việt Nam', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'FAD161', name: 'Nhập môn ngành Thiết kế thời trang', credits: 3, category: 'Đại cương'});

// ────────────────────────────────────────────────────────────────
// II.1. KIẾN THỨC CHUYÊN NGHIỆP BẮT BUỘC (69 tín chỉ)
// ────────────────────────────────────────────────────────────────
MERGE (:Course {id: 'ART212', name: 'Hình họa đen trắng', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FAD207', name: 'Kỹ thuật may', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FAD104', name: 'Lịch sử trang phục Việt Nam và thế giới', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FAD2001', name: 'Ký họa chuyên ngành thiết kế thời trang', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'GAR716', name: 'Kiến tập công ty dệt, may', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FAD105', name: 'Nguyên lý thiết kế thời trang', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FAD215', name: 'Thiết kế trang phục nữ', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'GRD415', name: 'Đồ án poster quảng cáo', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FAD1002', name: 'Vật liệu bền vững trong thời trang', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FAD424', name: 'Đồ án tạo mẫu', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ART109', name: 'Vẽ thời trang', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FAD423', name: 'Đồ án kỹ thuật xử lý chất liệu may', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FAD2003', name: 'Ứng dụng AI trong thiết kế thời trang', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FAD214', name: 'Thiết kế trang phục nam', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FAD140', name: 'Công nghệ dệt, may thời trang', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FAD447', name: 'Đồ án công nghệ dệt, may', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FAD4004', name: 'Đồ án thiết kế trang phục thường ngày', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FAD106', name: ' Tiếp thị và kinh doanh thời trang', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FAD464', name: 'Đồ án thiết kế trang phục event', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FAD242', name: 'Thiết kế rập trên Mannequin', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FAD101', name: 'Chuyên đề kiểm tra chất lượng sản phẩm', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FAD4005', name: 'Đồ án thiết kế trang phục nghệ thuật', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FAD5006', name: 'Thực tập thiết kế tạo phong cách', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FAD217', name: 'Thiết kế trang phục truyền thống', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ARH1019', name: 'Chuyên đề thiết kế hồ sơ năng lực cá nhân', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FAD544', name: 'Thực tập tốt nghiệp ngành Thiết kế thời trang', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FAD431', name: 'Đồ án tốt nghiệp Thiết kế thời trang', credits: 9, category: 'Chuyên nghiệp bắt buộc'});

// ────────────────────────────────────────────────────────────────
// II.2. KIẾN THỨC TỰ CHỌN (chọn 12 tín chỉ)
// ────────────────────────────────────────────────────────────────

// Nhóm 1: Nghệ thuật thiết kế trang phục
MERGE (:Course {id: 'FAD475', name: 'Đồ án tổng hợp thiết kế thời trang', credits: 3, category: 'Tự chọn - Nghệ thuật thiết kế trang phục'});
MERGE (:Course {id: 'FAD4007', name: 'Đồ án thiết kế phụ kiện thời trang', credits: 3, category: 'Tự chọn - Nghệ thuật thiết kế trang phục'});
MERGE (:Course {id: 'FAD2008', name: 'Thiết kế sản phẩm thủ công', credits: 3, category: 'Tự chọn - Nghệ thuật thiết kế trang phục'});
MERGE (:Course {id: 'FAD241', name: 'Thiết kế áo veston', credits: 3, category: 'Tự chọn - Nghệ thuật thiết kế trang phục'});

// Nhóm 2: Quản lý thương hiệu và kinh doanh thời trang
MERGE (:Course {id: 'FAD467', name: 'Đồ án tổng hợp xây dựng thương hiệu', credits: 3, category: 'Tự chọn - Quản lý thương hiệu và kinh doanh thời trang'});
MERGE (:Course {id: 'FAD468', name: 'Đồ án poster thương hiệu', credits: 3, category: 'Tự chọn - Quản lý thương hiệu và kinh doanh thời trang'});
MERGE (:Course {id: 'FAD269', name: 'Nghiên cứu thị trường thời trang', credits: 3, category: 'Tự chọn - Quản lý thương hiệu và kinh doanh thời trang'});
MERGE (:Course {id: 'FAD1009', name: 'Phát triển thương hiệu địa phương', credits: 3, category: 'Tự chọn - Quản lý thương hiệu và kinh doanh thời trang'});

// Nhóm 3: Thiết kế xây dựng phong cách
MERGE (:Course {id: 'FAD470', name: 'Đồ án tổng hợp xây dựng phong cách', credits: 3, category: 'Tự chọn - Thiết kế xây dựng phong cách'});
MERGE (:Course {id: 'ART233', name: 'Trang điểm', credits: 3, category: 'Tự chọn - Thiết kế xây dựng phong cách'});
MERGE (:Course {id: 'ART232', name: 'Nhiếp ảnh', credits: 3, category: 'Tự chọn - Thiết kế xây dựng phong cách'});
MERGE (:Course {id: 'FAD2010', name: 'Trình diễn', credits: 3, category: 'Tự chọn - Thiết kế xây dựng phong cách'});

// ────────────────────────────────────────────────────────────────
// III. KIẾN THỨC KHÔNG TÍCH LŨY
// ────────────────────────────────────────────────────────────────

// III.1. Giáo dục thể chất (5 tín chỉ)
// (Tận dụng các node PHT đã có từ các ngành khác)
MERGE (:Course {id: 'PHT304', name: 'Bóng chuyền 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT305', name: 'Bóng chuyền 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT306', name: 'Bóng chuyền 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT307', name: 'Bóng rổ 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT308', name: 'Bóng rổ 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT309', name: 'Bóng rổ 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT310', name: 'Thể hình - Thẩm mỹ 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT311', name: 'Thể hình - Thẩm mỹ 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT312', name: 'Thể hình - Thẩm mỹ 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT313', name: 'Vovinam 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT314', name: 'Vovinam 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT315', name: 'Vovinam 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT316', name: 'Bóng đá 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT317', name: 'Bóng đá 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT318', name: 'Bóng đá 3', credits: 1, category: 'Thể chất'});

// III.2. Giáo dục Quốc phòng và An ninh
MERGE (:Course {id: 'NDF108', name: 'Quốc phòng, an ninh 1', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF109', name: 'Quốc phòng, an ninh 2', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF210', name: 'Quốc phòng, an ninh 3', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF211', name: 'Quốc phòng, an ninh 4', credits: 0, category: 'Quốc phòng An ninh'});

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 3: LIÊN KẾT MÔN HỌC VỚI NGÀNH                        ║
// ╚══════════════════════════════════════════════════════════════╝
MATCH (c:Course), (m:Major {id: '7210404'})
MERGE (c)-[:BELONGS_TO]->(m);

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 4: MÔN TIÊN QUYẾT (PREREQUISITE_FOR)                  ║
// ║  Chiều: (Môn phải học trước)-[:PREREQUISITE_FOR]->(Môn sau)  ║
// ╚══════════════════════════════════════════════════════════════╝

// --- Anh ngữ: chuỗi tiên quyết ---
MATCH (a:Course {id: 'ENC120'}), (b:Course {id: 'ENC121'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'ENC121'}), (b:Course {id: 'ENC122'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'ENC122'}), (b:Course {id: 'ENC123'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// --- Kỹ năng ---
MATCH (a:Course {id: 'SKL115'}), (b:Course {id: 'SKL116'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// --- Chuyên ngành ---
MATCH (a:Course {id: 'FAD207'}), (b:Course {id: 'FAD215'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'FAD207'}), (b:Course {id: 'FAD214'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'FAD215'}), (b:Course {id: 'FAD424'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'FAD215'}), (b:Course {id: 'FAD242'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'FAD140'}), (b:Course {id: 'FAD447'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'FAD214'}), (b:Course {id: 'FAD241'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'FAD475'}), (b:Course {id: 'FAD431'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// --- Các đồ án cần Nguyên lý thiết kế (FAD105) ---
MATCH (p:Course {id: 'FAD105'})
WITH p
MATCH (c:Course) WHERE c.id IN ['FAD4004', 'FAD464', 'FAD4005', 'FAD475', 'FAD467', 'FAD468', 'FAD470']
MERGE (p)-[:PREREQUISITE_FOR]->(c);


// === NGANH 8/18: 8.Kế toán K25_Cypher.txt ===
// =============================================================================
// CHƯƠNG TRÌNH ĐÀO TẠO NGÀNH KẾ TOÁN (7340301) - ĐẠI HỌC HUTECH
// Đối tượng áp dụng: Đại học hệ chính quy từ khóa tuyển sinh năm 2025
// Tổng khối lượng: 125 tín chỉ tích lũy + 5 tín chỉ không tích lũy
// =============================================================================

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 0: XÓA DỮ LIỆU CŨ (chạy 1 lần trước khi import)    ║
// ╚══════════════════════════════════════════════════════════════╝

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 1: TẠO NODE NGÀNH                                     ║
// ╚══════════════════════════════════════════════════════════════╝
MERGE (:Major {id: '7340301', name: 'Kế toán', university: 'HUTECH', total_credits: 125, non_accum_credits: 5});

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 2: TẠO TẤT CẢ NODE MÔN HỌC                           ║
// ╚══════════════════════════════════════════════════════════════╝

// ────────────────────────────────────────────────────────────────
// I. KIẾN THỨC GIÁO DỤC ĐẠI CƯƠNG (44 tín chỉ)
// ────────────────────────────────────────────────────────────────
MERGE (:Course {id: 'POS104', name: 'Triết học Mác - Lênin', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'POS105', name: 'Kinh tế chính trị Mác - Lênin', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS106', name: 'Chủ nghĩa xã hội khoa học', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS107', name: 'Lịch sử Đảng Cộng sản Việt Nam', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS103', name: 'Tư tưởng Hồ Chí Minh', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'ENC120', name: 'Anh ngữ 1', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC121', name: 'Anh ngữ 2', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC122', name: 'Anh ngữ 3', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC123', name: 'Anh ngữ 4', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'AIT129', name: 'Trí tuệ nhân tạo ứng dụng', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENS192', name: 'Phát triển bền vững', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'LAW158', name: 'Luật và Khởi nghiệp', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'SKL115', name: 'Tư duy thiết kế dự án', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'MDC187', name: 'Giao tiếp chuyên nghiệp', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'MAN116', name: 'Quản trị học', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'PSY167', name: 'Tâm lý học ứng dụng', credits: 3, category: 'Đại cương'});

// ────────────────────────────────────────────────────────────────
// II.1. KIẾN THỨC CHUYÊN NGHIỆP BẮT BUỘC (72 tín chỉ)
// ────────────────────────────────────────────────────────────────
MERGE (:Course {id: 'ECO117', name: 'Kinh tế học', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ACC114', name: 'Nguyên lý kế toán', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FIN167', name: 'Lý thuyết tài chính', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ECO241', name: 'Phương pháp nghiên cứu kinh tế', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ACC156', name: 'Kế toán tài chính doanh nghiệp 1', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FIN2017', name: 'Thuế', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ACC1002', name: 'Kiểm toán căn bản', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ACC157', name: 'Kế toán tài chính doanh nghiệp 2', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FIN1018', name: 'Tài chính xanh và phát triển bền vững', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FIN1016', name: 'Phân tích và đầu tư chứng khoán', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ACC1003', name: 'Kế toán tài chính quốc tế 1', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ACC2009', name: 'Lập và trình bày báo cáo tài chính', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ACC105', name: 'Kế toán quản trị', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'BUS1009', name: 'ESG và đạo đức kinh doanh', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FIN2021', name: 'Phân tích dữ liệu trong tài chính kế toán', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FIN1019', name: 'Công nghệ tài chính', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ACC1004', name: 'Kế toán tài chính quốc tế 2', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'LAW1016', name: 'Cơ sở pháp lý trong kế toán', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'AIT2019', name: 'Ứng dụng AI trong tài chính kế toán', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FIN106', name: 'Phân tích báo cáo tài chính', credits: 3, category: 'Chuyên nghiệp bắt buộc'});

// Đồ án và Thực hành
MERGE (:Course {id: 'ACC365', name: 'Phần mềm kế toán doanh nghiệp', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ACC362', name: 'Thực hành kế toán doanh nghiệp', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ACC361', name: 'Thực hành kiểm toán', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ECO440', name: 'Đồ án nghiên cứu trong kinh tế', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ACC441', name: 'Đồ án kế toán tài chính', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ACC430', name: 'Đồ án chuyên ngành Kế toán', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ACC566', name: 'Dự án doanh nghiệp ngành Kế toán', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ACC539', name: 'Thực tập tốt nghiệp ngành Kế toán', credits: 3, category: 'Chuyên nghiệp bắt buộc'});

// ────────────────────────────────────────────────────────────────
// II.2. KIẾN THỨC TỰ CHỌN (chọn 9 tín chỉ)
// ────────────────────────────────────────────────────────────────

// Nhóm 1: Kế toán kiểm toán
MERGE (:Course {id: 'ACC142', name: 'Kiểm toán nội bộ doanh nghiệp', credits: 3, category: 'Tự chọn - Kế toán kiểm toán'});
MERGE (:Course {id: 'ACC127', name: 'Kiểm toán báo cáo tài chính', credits: 3, category: 'Tự chọn - Kế toán kiểm toán'});
MERGE (:Course {id: 'ACC1005', name: 'Kiểm toán công nghệ thông tin', credits: 3, category: 'Tự chọn - Kế toán kiểm toán'});

// Nhóm 2: Kế toán tài chính
MERGE (:Course {id: 'ACC104', name: 'Kế toán ngân hàng', credits: 3, category: 'Tự chọn - Kế toán tài chính'});
MERGE (:Course {id: 'ACC1006', name: 'Lập báo cáo tài chính quốc tế', credits: 3, category: 'Tự chọn - Kế toán tài chính'});
MERGE (:Course {id: 'ACC1007', name: 'Báo cáo phát triển bền vững', credits: 3, category: 'Tự chọn - Kế toán tài chính'});

// Nhóm 3: Khóa luận tốt nghiệp
MERGE (:Course {id: 'ACC4008', name: 'Khóa luận tốt nghiệp Kế toán', credits: 9, category: 'Tự chọn - Khóa luận tốt nghiệp'});

// ────────────────────────────────────────────────────────────────
// III. KIẾN THỨC KHÔNG TÍCH LŨY
// ────────────────────────────────────────────────────────────────

// III.1. Giáo dục thể chất (5 tín chỉ)
MERGE (:Course {id: 'PHT304', name: 'Bóng chuyền 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT305', name: 'Bóng chuyền 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT306', name: 'Bóng chuyền 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT307', name: 'Bóng rổ 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT308', name: 'Bóng rổ 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT309', name: 'Bóng rổ 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT310', name: 'Thể hình - Thẩm mỹ 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT311', name: 'Thể hình - Thẩm mỹ 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT312', name: 'Thể hình - Thẩm mỹ 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT313', name: 'Vovinam 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT314', name: 'Vovinam 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT315', name: 'Vovinam 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT316', name: 'Bóng đá 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT317', name: 'Bóng đá 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT318', name: 'Bóng đá 3', credits: 1, category: 'Thể chất'});

// III.2. Giáo dục Quốc phòng và An ninh
MERGE (:Course {id: 'NDF108', name: 'Quốc phòng, an ninh 1', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF109', name: 'Quốc phòng, an ninh 2', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF210', name: 'Quốc phòng, an ninh 3', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF211', name: 'Quốc phòng, an ninh 4', credits: 0, category: 'Quốc phòng An ninh'});

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 3: LIÊN KẾT MÔN HỌC VỚI NGÀNH                        ║
// ╚══════════════════════════════════════════════════════════════╝
MATCH (c:Course), (m:Major {id: '7340301'})
MERGE (c)-[:BELONGS_TO]->(m);

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 4: MÔN TIÊN QUYẾT (PREREQUISITE_FOR)                  ║
// ║  Chiều: (Môn phải học trước)-[:PREREQUISITE_FOR]->(Môn sau)  ║
// ╚══════════════════════════════════════════════════════════════╝

// --- Anh ngữ: chuỗi tiên quyết ---
MATCH (a:Course {id: 'ENC120'}), (b:Course {id: 'ENC121'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'ENC121'}), (b:Course {id: 'ENC122'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'ENC122'}), (b:Course {id: 'ENC123'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// --- Nền tảng Kế toán (ACC114, ACC157) ---
MATCH (a:Course {id: 'ACC114'}), (b:Course {id: 'ACC1003'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'ACC114'}), (b:Course {id: 'ACC104'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

MATCH (p:Course {id: 'ACC157'})
WITH p
MATCH (c:Course) WHERE c.id IN ['ACC2009', 'ACC365', 'ACC362', 'ACC441', 'ACC1006', 'ACC1007']
MERGE (p)-[:PREREQUISITE_FOR]->(c);

// --- Kiểm toán ---
MATCH (a:Course {id: 'ACC1002'})
WITH a
MATCH (c:Course) WHERE c.id IN ['ACC361', 'ACC539', 'ACC142', 'ACC127', 'ACC1005']
MERGE (a)-[:PREREQUISITE_FOR]->(c);

// --- Khác ---
MATCH (a:Course {id: 'ACC2009'}), (b:Course {id: 'ACC430'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'ACC2009'}), (b:Course {id: 'ACC539'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'ACC430'}), (b:Course {id: 'ACC566'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'ECO241'}), (b:Course {id: 'ECO440'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// --- Khóa luận tốt nghiệp (Cần ACC430 & ACC362) ---
MATCH (a:Course {id: 'ACC430'}), (k:Course {id: 'ACC4008'}) MERGE (a)-[:PREREQUISITE_FOR]->(k);
MATCH (a:Course {id: 'ACC362'}), (k:Course {id: 'ACC4008'}) MERGE (a)-[:PREREQUISITE_FOR]->(k);


// === NGANH 9/18: 9.Logistics và quản lý chuỗi cung ứng K25_Cypher.txt ===
// =============================================================================
// CHƯƠNG TRÌNH ĐÀO TẠO NGÀNH LOGISTICS VÀ QUẢN LÝ CHUỖI CUNG ỨNG (7510605) - ĐẠI HỌC HUTECH
// Đối tượng áp dụng: Đại học hệ chính quy từ khóa tuyển sinh năm 2025
// Tổng khối lượng: 125 tín chỉ tích lũy + 5 tín chỉ không tích lũy
// =============================================================================

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 0: XÓA DỮ LIỆU CŨ (chạy 1 lần trước khi import)    ║
// ╚══════════════════════════════════════════════════════════════╝

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 1: TẠO NODE NGÀNH                                     ║
// ╚══════════════════════════════════════════════════════════════╝
MERGE (:Major {id: '7510605', name: 'Logistics và quản lý chuỗi cung ứng', university: 'HUTECH', total_credits: 125, non_accum_credits: 5});

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 2: TẠO TẤT CẢ NODE MÔN HỌC                           ║
// ╚══════════════════════════════════════════════════════════════╝

// ────────────────────────────────────────────────────────────────
// I. KIẾN THỨC GIÁO DỤC ĐẠI CƯƠNG (44 tín chỉ)
// ────────────────────────────────────────────────────────────────
MERGE (:Course {id: 'POS104', name: 'Triết học Mác - Lênin', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'POS105', name: 'Kinh tế chính trị Mác - Lênin', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS106', name: 'Chủ nghĩa xã hội khoa học', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS107', name: 'Lịch sử Đảng Cộng sản Việt Nam', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS103', name: 'Tư tưởng Hồ Chí Minh', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'ENC120', name: 'Anh ngữ 1', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC121', name: 'Anh ngữ 2', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC122', name: 'Anh ngữ 3', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC123', name: 'Anh ngữ 4', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'AIT129', name: 'Trí tuệ nhân tạo ứng dụng', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENS192', name: 'Phát triển bền vững', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'LAW106', name: 'Pháp luật đại cương', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'SKL115', name: 'Tư duy thiết kế dự án', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'SKL101', name: 'Khởi nghiệp', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'MAN116', name: 'Quản trị học', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'MAT124', name: 'Toán ứng dụng trong kinh tế', credits: 3, category: 'Đại cương'});

// ────────────────────────────────────────────────────────────────
// II.1. KIẾN THỨC CHUYÊN NGHIỆP BẮT BUỘC (72 tín chỉ)
// ────────────────────────────────────────────────────────────────
MERGE (:Course {id: 'MAR146', name: 'Nguyên lý marketing', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAN1104', name: 'Tổng quan logistics và quản trị chuỗi cung ứng bền vững', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ECO1014', name: 'Nguyên lý kinh tế học', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAT1003', name: 'Thống kê và kinh tế lượng ứng dụng', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAN1053', name: 'Phương pháp nghiên cứu và phân tích dữ liệu trong kinh doanh', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAN2053', name: 'Quản trị hành chính văn phòng', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAN119', name: 'Quản trị kinh doanh quốc tế', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAN135', name: 'Quản trị nguồn nhân lực', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAN114', name: 'Quản trị chiến lược', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAN1105', name: 'Quản trị xuất nhập khẩu', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'BUS103', name: 'Thanh toán quốc tế', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'BUS222', name: 'Mô phỏng đơn hàng thương mại', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAN111', name: 'Quản trị bán hàng', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'INS1001', name: 'Bảo hiểm hàng hóa trong vận tải quốc tế', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAN170', name: 'Quản trị kho hàng và tồn kho', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAN187', name: 'Vận tải đa phương thức', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'BUS126', name: 'Nghiệp vụ giao nhận và khai báo hải quan', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAN1025', name: 'Quản trị hệ thống kênh phân phối trong logistics', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAN1026', name: 'Quản trị hoạt động đóng gói và xử lý vật liệu', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAN1027', name: 'Quản trị logistics thu hồi', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAN1034', name: 'Quản trị thu mua', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FIN1014', name: 'Tài chính ứng dụng trong kinh tế doanh nghiệp', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAN5106', name: 'Ứng dụng ERP ngành Logistics và quản lý chuỗi cung ứng', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAN5001', name: 'Thực tập tốt nghiệp ngành Logistics và quản lý chuỗi cung ứng', credits: 3, category: 'Chuyên nghiệp bắt buộc'});

// ────────────────────────────────────────────────────────────────
// II.2. KIẾN THỨC TỰ CHỌN (chọn 9 tín chỉ)
// ────────────────────────────────────────────────────────────────

// Nhóm 1: Logistics vận tải
MERGE (:Course {id: 'MAN4029', name: 'Đồ án logistics vận tải', credits: 3, category: 'Tự chọn - Logistics vận tải'});
MERGE (:Course {id: 'MAN1028', name: 'Vận tải và khai thác cảng', credits: 3, category: 'Tự chọn - Logistics vận tải'});
MERGE (:Course {id: 'MAN1107', name: 'Logistics vận tải biển và hàng không', credits: 3, category: 'Tự chọn - Logistics vận tải'});

// Nhóm 2: Quản trị chuỗi cung ứng
MERGE (:Course {id: 'MAN4032', name: 'Đồ án quản trị chuỗi cung ứng', credits: 3, category: 'Tự chọn - Quản trị chuỗi cung ứng'});
MERGE (:Course {id: 'MAN128', name: 'Quản trị sản xuất', credits: 3, category: 'Tự chọn - Quản trị chuỗi cung ứng'});
MERGE (:Course {id: 'MAN1086', name: 'Quản trị rủi ro và an toàn trong chuỗi cung ứng', credits: 3, category: 'Tự chọn - Quản trị chuỗi cung ứng'});

// Nhóm 3: Khóa luận tốt nghiệp
MERGE (:Course {id: 'MAN4108', name: 'Khóa luận tốt nghiệp Logistics và quản lý chuỗi cung ứng', credits: 9, category: 'Tự chọn - Khóa luận tốt nghiệp'});

// ────────────────────────────────────────────────────────────────
// III. KIẾN THỨC KHÔNG TÍCH LŨY
// ────────────────────────────────────────────────────────────────

// III.1. Giáo dục thể chất (5 tín chỉ)
MERGE (:Course {id: 'PHT304', name: 'Bóng chuyền 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT305', name: 'Bóng chuyền 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT306', name: 'Bóng chuyền 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT307', name: 'Bóng rổ 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT308', name: 'Bóng rổ 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT309', name: 'Bóng rổ 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT310', name: 'Thể hình - Thẩm mỹ 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT311', name: 'Thể hình - Thẩm mỹ 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT312', name: 'Thể hình - Thẩm mỹ 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT313', name: 'Vovinam 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT314', name: 'Vovinam 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT315', name: 'Vovinam 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT316', name: 'Bóng đá 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT317', name: 'Bóng đá 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT318', name: 'Bóng đá 3', credits: 1, category: 'Thể chất'});

// III.2. Giáo dục Quốc phòng và An ninh
MERGE (:Course {id: 'NDF108', name: 'Quốc phòng, an ninh 1', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF109', name: 'Quốc phòng, an ninh 2', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF210', name: 'Quốc phòng, an ninh 3', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF211', name: 'Quốc phòng, an ninh 4', credits: 0, category: 'Quốc phòng An ninh'});

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 3: LIÊN KẾT MÔN HỌC VỚI NGÀNH                        ║
// ╚══════════════════════════════════════════════════════════════╝
MATCH (c:Course), (m:Major {id: '7510605'})
MERGE (c)-[:BELONGS_TO]->(m);

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 4: MÔN TIÊN QUYẾT (PREREQUISITE_FOR)                  ║
// ║  Chiều: (Môn phải học trước)-[:PREREQUISITE_FOR]->(Môn sau)  ║
// ╚══════════════════════════════════════════════════════════════╝

// --- Anh ngữ: chuỗi tiên quyết ---
MATCH (a:Course {id: 'ENC120'}), (b:Course {id: 'ENC121'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'ENC121'}), (b:Course {id: 'ENC122'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'ENC122'}), (b:Course {id: 'ENC123'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// --- Nền tảng Quản trị (MAN116) ---
MATCH (p:Course {id: 'MAN116'})
WITH p
MATCH (c:Course) WHERE c.id IN ['MAN2053', 'MAN119', 'MAN135', 'MAN114', 'FIN1014', 'MAN128']
MERGE (p)-[:PREREQUISITE_FOR]->(c);

// --- Logistics & SCM ---
MATCH (a:Course {id: 'MAT1003'}), (b:Course {id: 'MAN1053'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'MAN1105'}), (b:Course {id: 'BUS222'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'MAN1105'}), (b:Course {id: 'BUS126'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'MAR146'}), (b:Course {id: 'MAN111'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'MAN1104'}), (b:Course {id: 'MAN5106'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'MAN187'}), (b:Course {id: 'MAN1107'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// --- Đồ án ---
MATCH (a:Course {id: 'SKL115'}), (b:Course {id: 'MAN4029'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'SKL115'}), (b:Course {id: 'MAN4032'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);


// === NGANH 10/18: An toàn thông tin K25_Cypher.txt ===
// =============================================================================
// CHƯƠNG TRÌNH ĐÀO TẠO NGÀNH AN TOÀN THÔNG TIN (7480202) - ĐẠI HỌC HUTECH
// Đối tượng áp dụng: Đại học hệ chính quy từ khóa tuyển sinh năm 2025
// Tổng khối lượng: 150 tín chỉ tích lũy + 5 tín chỉ không tích lũy
// =============================================================================

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 0: XÓA DỮ LIỆU CŨ (chạy 1 lần trước khi import)    ║
// ╚══════════════════════════════════════════════════════════════╝

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 1: TẠO NODE NGÀNH                                     ║
// ╚══════════════════════════════════════════════════════════════╝
MERGE (:Major {id: '7480202', name: 'An toàn thông tin', university: 'HUTECH', total_credits: 150, non_accum_credits: 5});

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 2: TẠO TẤT CẢ NODE MÔN HỌC                           ║
// ╚══════════════════════════════════════════════════════════════╝

// ────────────────────────────────────────────────────────────────
// I. KIẾN THỨC GIÁO DỤC ĐẠI CƯƠNG (50 tín chỉ)
// ────────────────────────────────────────────────────────────────
MERGE (:Course {id: 'POS104', name: 'Triết học Mác - Lênin', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'POS105', name: 'Kinh tế chính trị Mác - Lênin', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS106', name: 'Chủ nghĩa xã hội khoa học', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS107', name: 'Lịch sử Đảng Cộng sản Việt Nam', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS103', name: 'Tư tưởng Hồ Chí Minh', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'ENC120', name: 'Anh ngữ 1', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC121', name: 'Anh ngữ 2', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC122', name: 'Anh ngữ 3', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC123', name: 'Anh ngữ 4', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENS192', name: 'Phát triển bền vững', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'LAW106', name: 'Pháp luật đại cương', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'SKL115', name: 'Tư duy thiết kế dự án', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'SKL116', name: 'Đổi mới sáng tạo và tư duy khởi nghiệp', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'CMP6085', name: 'Nhập môn ngành An toàn thông tin', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'MAT101', name: 'Đại số tuyến tính', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'MAT118', name: 'Giải tích', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'MAT105', name: 'Xác suất thống kê', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'MAT104', name: 'Toán rời rạc', credits: 3, category: 'Đại cương'});

// ────────────────────────────────────────────────────────────────
// II.1. KIẾN THỨC CHUYÊN NGHIỆP BẮT BUỘC (91 tín chỉ)
// ────────────────────────────────────────────────────────────────
MERGE (:Course {id: 'COS142', name: 'An toàn web và cơ sở dữ liệu', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP174', name: 'Bảo mật thông tin', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'COS120', name: 'Cấu trúc dữ liệu và giải thuật', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CIS1001', name: 'Cơ sở an toàn hạ tầng công nghệ thông tin', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'COS135', name: 'Nhập môn cơ sở dữ liệu', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'COS1002', name: 'Các hệ quản trị cơ sở dữ liệu', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CIS1002', name: 'An toàn hệ điều hành máy chủ', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP1001', name: 'Kiểm thử và giám sát an toàn mạng', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'COS117', name: 'Kiến trúc và hệ điều hành máy tính', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'COS129', name: 'Điện toán đám mây', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP1074', name: 'Cơ sở lập trình', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP164', name: 'Kỹ thuật lập trình', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP167', name: 'Lập trình hướng đối tượng', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP1093', name: 'Lập trình an toàn hệ thống', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP170', name: 'Lập trình trên môi trường Windows', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP175', name: 'Lập trình web', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP172', name: 'Mạng máy tính', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'COS148', name: 'Tấn công và phòng thủ', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP198', name: 'Phân tích mã độc', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'AIT1001', name: 'Cơ sở trí tuệ nhân tạo', credits: 3, category: 'Chuyên nghiệp bắt buộc'});

// Đồ án và Thực hành
MERGE (:Course {id: 'COS344', name: 'Thực hành an toàn web và cơ sở dữ liệu', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP3087', name: 'Thực hành an toàn hệ điều hành máy chủ', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP382', name: 'Thực hành bảo mật thông tin', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'COS321', name: 'Thực hành cấu trúc dữ liệu và giải thuật', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'COS323', name: 'Thực hành cơ sở dữ liệu', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP3003', name: 'Thực hành giám sát an toàn mạng', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP3090', name: 'Thực hành kiến trúc và hệ điều hành máy tính', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP3002', name: 'Thực hành kiểm thử xâm nhập mạng', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP5089', name: 'Thực tập điện toán đám mây', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP365', name: 'Thực hành kỹ thuật lập trình', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP3075', name: 'Thực hành Cơ sở lập trình', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP368', name: 'Thực hành lập trình hướng đối tượng', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP3094', name: 'Thực hành lập trình an toàn hệ thống', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP371', name: 'Thực hành lập trình trên môi trường Windows', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP376', name: 'Thực hành lập trình web', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP3014', name: 'Thực hành lý thuyết đồ thị', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP373', name: 'Thực hành mạng máy tính', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP399', name: 'Thực hành phân tích mã độc', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'COS324', name: 'Thực hành quản trị cơ sở dữ liệu', credits: 1, category: 'Chuyên nghiệp bắt buộc'});

MERGE (:Course {id: 'CIS1003', name: 'Kiểm thử an toàn phần mềm và phân tích mã nguồn', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CIS5004', name: 'Thực tập cơ sở ngành An toàn thông tin', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP456', name: 'Đồ án chuyên ngành An toàn thông tin', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP5006', name: 'Thực tập tốt nghiệp ngành An toàn thông tin', credits: 3, category: 'Chuyên nghiệp bắt buộc'});

// ────────────────────────────────────────────────────────────────
// II.2. KIẾN THỨC TỰ CHỌN (chọn 9 tín chỉ)
// ────────────────────────────────────────────────────────────────

// Nhóm 1: Công nghệ an ninh mạng
MERGE (:Course {id: 'CMP1076', name: 'Điều tra số', credits: 3, category: 'Tự chọn - Công nghệ an ninh mạng'});
MERGE (:Course {id: 'CMP1077', name: 'Kiến trúc an toàn mạng', credits: 3, category: 'Tự chọn - Công nghệ an ninh mạng'});
MERGE (:Course {id: 'CIS1005', name: 'An toàn hệ thống mạng máy tính và đám mây', credits: 3, category: 'Tự chọn - Công nghệ an ninh mạng'});

// Nhóm 2: Công nghệ an ninh phần mềm
MERGE (:Course {id: 'COS147', name: 'Lập trình phân tích an toàn mạng', credits: 3, category: 'Tự chọn - Công nghệ an ninh phần mềm'});
MERGE (:Course {id: 'CMP1095', name: 'Lập trình an toàn trên thiết bị di động', credits: 3, category: 'Tự chọn - Công nghệ an ninh phần mềm'});
MERGE (:Course {id: 'COS149', name: 'Công nghệ phát triển phần mềm an toàn', credits: 3, category: 'Tự chọn - Công nghệ an ninh phần mềm'});

// Nhóm 3: Đồ án tốt nghiệp
MERGE (:Course {id: 'CIS4006', name: 'Đồ án tốt nghiệp An toàn thông tin', credits: 9, category: 'Tự chọn - Đồ án tốt nghiệp'});

// ────────────────────────────────────────────────────────────────
// III. KIẾN THỨC KHÔNG TÍCH LŨY
// ────────────────────────────────────────────────────────────────

// III.1. Giáo dục thể chất (5 tín chỉ)
MERGE (:Course {id: 'PHT304', name: 'Bóng chuyền 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT305', name: 'Bóng chuyền 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT306', name: 'Bóng chuyền 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT307', name: 'Bóng rổ 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT308', name: 'Bóng rổ 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT309', name: 'Bóng rổ 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT310', name: 'Thể hình - Thẩm mỹ 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT311', name: 'Thể hình - Thẩm mỹ 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT312', name: 'Thể hình - Thẩm mỹ 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT313', name: 'Vovinam 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT314', name: 'Vovinam 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT315', name: 'Vovinam 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT316', name: 'Bóng đá 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT317', name: 'Bóng đá 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT318', name: 'Bóng đá 3', credits: 1, category: 'Thể chất'});

// III.2. Giáo dục Quốc phòng và An ninh
MERGE (:Course {id: 'NDF108', name: 'Quốc phòng, an ninh 1', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF109', name: 'Quốc phòng, an ninh 2', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF210', name: 'Quốc phòng, an ninh 3', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF211', name: 'Quốc phòng, an ninh 4', credits: 0, category: 'Quốc phòng An ninh'});

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 3: LIÊN KẾT MÔN HỌC VỚI NGÀNH                        ║
// ╚══════════════════════════════════════════════════════════════╝
MATCH (c:Course), (m:Major {id: '7480202'})
WHERE c.id IN [
    'POS104', 'POS105', 'POS106', 'POS107', 'POS103', 'ENC120', 'ENC121', 'ENC122',
    'ENC123', 'ENS192', 'LAW106', 'SKL115', 'SKL116', 'CMP6085', 'MAT101', 'MAT118',
    'MAT105', 'MAT104', 'COS142', 'CMP174', 'COS120', 'CIS1001', 'COS135', 'COS1002',
    'CIS1002', 'CMP1001', 'COS117', 'COS129', 'CMP1074', 'CMP164', 'CMP167', 'CMP1093',
    'CMP170', 'CMP175', 'CMP172', 'COS148', 'CMP198', 'AIT1001', 'COS344', 'CMP3087',
    'CMP382', 'COS321', 'COS323', 'CMP3003', 'CMP3090', 'CMP3002', 'CMP5089', 'CMP365',
    'CMP3075', 'CMP368', 'CMP3094', 'CMP371', 'CMP376', 'CMP3014', 'CMP373', 'CMP399',
    'COS324', 'CIS1003', 'CIS5004', 'CMP456', 'CMP5006', 'CMP1076', 'CMP1077', 'CIS1005',
    'COS147', 'CMP1095', 'COS149', 'CIS4006', 'PHT304', 'PHT305', 'PHT306', 'PHT307',
    'PHT308', 'PHT309', 'PHT310', 'PHT311', 'PHT312', 'PHT313', 'PHT314', 'PHT315',
    'PHT316', 'PHT317', 'PHT318', 'NDF108', 'NDF109', 'NDF210', 'NDF211'
]
MERGE (c)-[:BELONGS_TO]->(m);

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 4: MÔN TIÊN QUYẾT (PREREQUISITE_FOR)                  ║
// ║  Chiều: (Môn phải học trước)-[:PREREQUISITE_FOR]->(Môn sau)  ║
// ╚══════════════════════════════════════════════════════════════╝

// --- Anh ngữ: chuỗi tiên quyết ---
MATCH (a:Course {id: 'ENC120'}), (b:Course {id: 'ENC121'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'ENC121'}), (b:Course {id: 'ENC122'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'ENC122'}), (b:Course {id: 'ENC123'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// --- Kỹ năng ---
MATCH (a:Course {id: 'SKL115'}), (b:Course {id: 'SKL116'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// --- Chuỗi Lập trình ---
MATCH (a:Course {id: 'CMP1074'}), (b:Course {id: 'CMP164'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'CMP164'}), (b:Course {id: 'COS120'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'CMP167'}), (b:Course {id: 'CMP174'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'CMP167'}), (b:Course {id: 'CMP170'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'CMP167'}), (b:Course {id: 'CMP175'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'CMP167'}), (b:Course {id: 'COS148'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// --- Chuỗi An toàn ---
MATCH (a:Course {id: 'CMP175'}), (b:Course {id: 'COS142'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'CMP174'}), (b:Course {id: 'CMP1093'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'CMP172'}), (b:Course {id: 'CMP1001'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 5: MÔN SONG HÀNH (COREQUISITE_WITH)                  ║
// ║  Chiều: (Thực hành)-[:COREQUISITE_WITH]->(Lý thuyết)        ║
// ╚══════════════════════════════════════════════════════════════╝
MATCH (a:Course {id: 'COS344'}), (b:Course {id: 'COS142'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'CMP382'}), (b:Course {id: 'CMP174'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'COS321'}), (b:Course {id: 'COS120'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'COS323'}), (b:Course {id: 'COS135'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'CMP3003'}), (b:Course {id: 'CMP1001'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'CMP3090'}), (b:Course {id: 'COS117'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'CMP3002'}), (b:Course {id: 'CMP1001'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'CMP5089'}), (b:Course {id: 'COS129'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'CMP365'}), (b:Course {id: 'CMP164'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'CMP3075'}), (b:Course {id: 'CMP1074'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'CMP368'}), (b:Course {id: 'CMP167'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'CMP3094'}), (b:Course {id: 'CMP1093'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'CMP371'}), (b:Course {id: 'CMP170'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'CMP376'}), (b:Course {id: 'CMP175'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'CMP373'}), (b:Course {id: 'CMP172'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'CMP399'}), (b:Course {id: 'CMP198'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'COS324'}), (b:Course {id: 'COS1002'}) MERGE (a)-[:COREQUISITE_WITH]->(b);


// === NGANH 11/18: Công nghệ thực phẩm K25_Cypher.txt ===
// =============================================================================
// CHƯƠNG TRÌNH ĐÀO TẠO NGÀNH CÔNG NGHỆ THỰC PHẨM (7540101) - ĐẠI HỌC HUTECH
// Đối tượng áp dụng: Đại học hệ chính quy từ khóa tuyển sinh năm 2025
// Tổng khối lượng: 125 tín chỉ tích lũy + 5 tín chỉ không tích lũy
// =============================================================================

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 0: XÓA DỮ LIỆU CŨ (chạy 1 lần trước khi import)    ║
// ╚══════════════════════════════════════════════════════════════╝

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 1: TẠO NODE NGÀNH                                     ║
// ╚══════════════════════════════════════════════════════════════╝
MERGE (:Major {id: '7540101', name: 'Công nghệ thực phẩm', university: 'HUTECH', total_credits: 125, non_accum_credits: 5});

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 2: TẠO TẤT CẢ NODE MÔN HỌC                           ║
// ╚══════════════════════════════════════════════════════════════╝

// ────────────────────────────────────────────────────────────────
// I. KIẾN THỨC GIÁO DỤC ĐẠI CƯƠNG (44 tín chỉ)
// ────────────────────────────────────────────────────────────────
MERGE (:Course {id: 'POS104', name: 'Triết học Mác - Lênin', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'POS105', name: 'Kinh tế chính trị Mác - Lênin', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS106', name: 'Chủ nghĩa xã hội khoa học', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS107', name: 'Lịch sử Đảng Cộng sản Việt Nam', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS103', name: 'Tư tưởng Hồ Chí Minh', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'ENC120', name: 'Anh ngữ 1', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC121', name: 'Anh ngữ 2', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC122', name: 'Anh ngữ 3', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC123', name: 'Anh ngữ 4', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'AIT129', name: 'Trí tuệ nhân tạo ứng dụng', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENS192', name: 'Phát triển bền vững', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'LAW158', name: 'Luật và Khởi nghiệp', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'SKL115', name: 'Tư duy thiết kế dự án', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'FOT160', name: 'Dinh dưỡng, thực phẩm và sức khỏe', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'CHE2004', name: 'Hóa đại cương', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'MAN116', name: 'Quản trị học', credits: 3, category: 'Đại cương'});

// ────────────────────────────────────────────────────────────────
// II.1. KIẾN THỨC CHUYÊN NGHIỆP BẮT BUỘC (72 tín chỉ)
// ────────────────────────────────────────────────────────────────
MERGE (:Course {id: 'FOT165', name: 'Nhập môn ngành Công nghệ thực phẩm', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FOT2001', name: 'Công nghệ bảo quản, chế biến lương thực', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FOT2002', name: 'Công nghệ bảo quản, chế biến rau quả', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FOT2003', name: 'Công nghệ bảo quản, chế biến thịt và thủy sản', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FOT108', name: 'Công nghệ đồ hộp thực phẩm', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FOT166', name: 'Truyền thông thực phẩm', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FOT219', name: 'Đánh giá cảm quan thực phẩm', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FOT2004', name: 'Hóa thực phẩm', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CHE267', name: 'Hóa lý và kỹ thuật phòng thí nghiệm hóa', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FOT2005', name: 'Hóa phân tích thực phẩm', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FOT2006', name: 'Hóa sinh học thực phẩm', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'BIO115', name: 'Vi sinh thực phẩm', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FOT112', name: 'Phát triển sản phẩm thực phẩm', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FOT220', name: 'Phân tích kiểm nghiệm thực phẩm', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FOT2007', name: 'Bao bì và phụ gia thực phẩm', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FOT168', name: 'Các quá trình cơ bản trong công nghệ thực phẩm', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAR168', name: 'Marketing thực phẩm', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAN101', name: 'Quản lý chất lượng thực phẩm', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CAP203', name: 'Quy hoạch và xử lý số liệu thực nghiệm', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FOT269', name: 'Dinh dưỡng và an toàn thực phẩm', credits: 3, category: 'Chuyên nghiệp bắt buộc'});

// Đồ án và Thực hành
MERGE (:Course {id: 'FOT326', name: 'Thực hành công nghệ đồ hộp thực phẩm', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'NFS5005', name: 'Dự án dinh dưỡng và khoa học thực phẩm', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FOT5008', name: 'Dự án phát triển sản phẩm', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FOT5009', name: 'Dự án quản lý sản xuất thực phẩm', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'BIO331', name: 'Thực hành vi sinh thực phẩm', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FOT547', name: 'Thực tập tốt nghiệp ngành Công nghệ thực phẩm', credits: 3, category: 'Chuyên nghiệp bắt buộc'});

// ────────────────────────────────────────────────────────────────
// II.2. KIẾN THỨC TỰ CHỌN (chọn 9 tín chỉ)
// ────────────────────────────────────────────────────────────────

// Nhóm 1: Quản lý sản xuất thực phẩm và công nghệ đồ uống
MERGE (:Course {id: 'FOT245', name: 'Công nghệ chế biến trà, cà phê cacao', credits: 3, category: 'Tự chọn - Quản lý sản xuất thực phẩm'});
MERGE (:Course {id: 'FOT2010', name: 'Công nghệ sản xuất đường, bánh kẹo, đồ uống', credits: 3, category: 'Tự chọn - Quản lý sản xuất thực phẩm'});
MERGE (:Course {id: 'FOT429', name: 'Đồ án quản lý sản xuất thực phẩm', credits: 3, category: 'Tự chọn - Quản lý sản xuất thực phẩm'});

// Nhóm 2: Quản lý chuỗi cung ứng thực phẩm và công nghệ đường bánh kẹo
MERGE (:Course {id: 'FOT216', name: 'Công nghệ chế biến sữa', credits: 3, category: 'Tự chọn - Quản lý chuỗi cung ứng thực phẩm'});
MERGE (:Course {id: 'FOT270', name: 'Quản lý chuỗi cung ứng và truy xuất nguồn gốc thực phẩm', credits: 3, category: 'Tự chọn - Quản lý chuỗi cung ứng thực phẩm'});
MERGE (:Course {id: 'FOT427', name: 'Đồ án công nghệ thực phẩm', credits: 3, category: 'Tự chọn - Quản lý chuỗi cung ứng thực phẩm'});

// Nhóm 3: Đồ án tốt nghiệp
MERGE (:Course {id: 'FOT430', name: 'Đồ án tốt nghiệp Công nghệ thực phẩm', credits: 9, category: 'Tự chọn - Đồ án tốt nghiệp'});

// ────────────────────────────────────────────────────────────────
// III. KIẾN THỨC KHÔNG TÍCH LŨY
// ────────────────────────────────────────────────────────────────

// III.1. Giáo dục thể chất (5 tín chỉ)
MERGE (:Course {id: 'PHT304', name: 'Bóng chuyền 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT305', name: 'Bóng chuyền 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT306', name: 'Bóng chuyền 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT307', name: 'Bóng rổ 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT308', name: 'Bóng rổ 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT309', name: 'Bóng rổ 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT310', name: 'Thể hình - Thẩm mỹ 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT311', name: 'Thể hình - Thẩm mỹ 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT312', name: 'Thể hình - Thẩm mỹ 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT313', name: 'Vovinam 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT314', name: 'Vovinam 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT315', name: 'Vovinam 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT316', name: 'Bóng đá 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT317', name: 'Bóng đá 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT318', name: 'Bóng đá 3', credits: 1, category: 'Thể chất'});

// III.2. Giáo dục Quốc phòng và An ninh
MERGE (:Course {id: 'NDF108', name: 'Quốc phòng, an ninh 1', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF109', name: 'Quốc phòng, an ninh 2', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF210', name: 'Quốc phòng, an ninh 3', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF211', name: 'Quốc phòng, an ninh 4', credits: 0, category: 'Quốc phòng An ninh'});

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 3: LIÊN KẾT MÔN HỌC VỚI NGÀNH                        ║
// ╚══════════════════════════════════════════════════════════════╝
MATCH (c:Course), (m:Major {id: '7540101'})
WHERE c.id IN [
    'POS104', 'POS105', 'POS106', 'POS107', 'POS103', 'ENC120', 'ENC121', 'ENC122',
    'ENC123', 'AIT129', 'ENS192', 'LAW158', 'SKL115', 'FOT160', 'CHE2004', 'MAN116',
    'FOT165', 'FOT2001', 'FOT2002', 'FOT2003', 'FOT108', 'FOT166', 'FOT219', 'FOT2004',
    'CHE267', 'FOT2005', 'FOT2006', 'BIO115', 'FOT112', 'FOT220', 'FOT2007', 'FOT168',
    'MAR168', 'MAN101', 'CAP203', 'FOT269', 'FOT326', 'NFS5005', 'FOT5008', 'FOT5009',
    'BIO331', 'FOT547', 'FOT245', 'FOT2010', 'FOT429', 'FOT216', 'FOT270', 'FOT427',
    'FOT430', 'PHT304', 'PHT305', 'PHT306', 'PHT307', 'PHT308', 'PHT309', 'PHT310',
    'PHT311', 'PHT312', 'PHT313', 'PHT314', 'PHT315', 'PHT316', 'PHT317', 'PHT318',
    'NDF108', 'NDF109', 'NDF210', 'NDF211'
]
MERGE (c)-[:BELONGS_TO]->(m);

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 4: MÔN TIÊN QUYẾT (PREREQUISITE_FOR)                  ║
// ║  Chiều: (Môn phải học trước)-[:PREREQUISITE_FOR]->(Môn sau)  ║
// ╚══════════════════════════════════════════════════════════════╝

// --- Anh ngữ: chuỗi tiên quyết ---
MATCH (a:Course {id: 'ENC120'}), (b:Course {id: 'ENC121'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'ENC121'}), (b:Course {id: 'ENC122'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'ENC122'}), (b:Course {id: 'ENC123'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// --- Công nghệ bảo quản & Chế biến ---
MATCH (a:Course {id: 'FOT2004'}), (b:Course {id: 'FOT2001'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'FOT2004'}), (b:Course {id: 'FOT245'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'FOT2004'}), (b:Course {id: 'FOT2010'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'FOT2004'}), (b:Course {id: 'FOT216'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'FOT2004'}), (b:Course {id: 'FOT427'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// --- Cơ sở ngành ---
MATCH (a:Course {id: 'BIO115'}), (b:Course {id: 'FOT108'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'CAP203'}), (b:Course {id: 'FOT219'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'FOT160'}), (b:Course {id: 'FOT269'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// --- Quản lý chất lượng & Sản xuất ---
MATCH (a:Course {id: 'FOT2003'}), (b:Course {id: 'MAN101'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'MAN101'}), (b:Course {id: 'FOT5009'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'MAN101'}), (b:Course {id: 'FOT429'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'MAN101'}), (b:Course {id: 'FOT270'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// --- Phát triển sản phẩm & Dinh dưỡng ---
MATCH (a:Course {id: 'FOT112'}), (b:Course {id: 'FOT5008'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'FOT269'}), (b:Course {id: 'NFS5005'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 5: MÔN SONG HÀNH (COREQUISITE_WITH)                  ║
// ║  Chiều: (Thực hành/Đồ án)-[:COREQUISITE_WITH]->(Lý thuyết)  ║
// ╚══════════════════════════════════════════════════════════════╝
MATCH (a:Course {id: 'FOT326'}), (b:Course {id: 'FOT108'}) MERGE (a)-[:COREQUISITE_WITH]->(b);


// === NGANH 12/18: Hệ thống thông tin quản lý K25_Cypher.txt ===
// =============================================================================
// CHƯƠNG TRÌNH ĐÀO TẠO NGÀNH HỆ THỐNG THÔNG TIN QUẢN LÝ (7340405) - ĐẠI HỌC HUTECH
// Đối tượng áp dụng: Đại học hệ chính quy từ khóa tuyển sinh năm 2025
// Tổng khối lượng: 125 tín chỉ tích lũy + 5 tín chỉ không tích lũy
// =============================================================================

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 0: XÓA DỮ LIỆU CŨ (chạy 1 lần trước khi import)    ║
// ╚══════════════════════════════════════════════════════════════╝

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 1: TẠO NODE NGÀNH                                     ║
// ╚══════════════════════════════════════════════════════════════╝
MERGE (:Major {id: '7340405', name: 'Hệ thống thông tin quản lý', university: 'HUTECH', total_credits: 125, non_accum_credits: 5});

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 2: TẠO TẤT CẢ NODE MÔN HỌC                           ║
// ╚══════════════════════════════════════════════════════════════╝

// ────────────────────────────────────────────────────────────────
// I. KIẾN THỨC GIÁO DỤC ĐẠI CƯƠNG (44 tín chỉ)
// ────────────────────────────────────────────────────────────────
MERGE (:Course {id: 'POS104', name: 'Triết học Mác - Lênin', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'POS105', name: 'Kinh tế chính trị Mác - Lênin', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS106', name: 'Chủ nghĩa xã hội khoa học', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS107', name: 'Lịch sử Đảng Cộng sản Việt Nam', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS103', name: 'Tư tưởng Hồ Chí Minh', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'ENC120', name: 'Anh ngữ 1', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC121', name: 'Anh ngữ 2', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC122', name: 'Anh ngữ 3', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC123', name: 'Anh ngữ 4', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'AIT129', name: 'Trí tuệ nhân tạo ứng dụng', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENS192', name: 'Phát triển bền vững', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'LAW158', name: 'Luật và Khởi nghiệp', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'SKL115', name: 'Tư duy thiết kế dự án', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'SKL102', name: 'Kỹ năng thuyết trình và tìm việc', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'MAN116', name: 'Quản trị học', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ACC114', name: 'Nguyên lý kế toán', credits: 3, category: 'Đại cương'});

// ────────────────────────────────────────────────────────────────
// II.1. KIẾN THỨC CHUYÊN NGHIỆP BẮT BUỘC (72 tín chỉ)
// ────────────────────────────────────────────────────────────────
MERGE (:Course {id: 'MIS120', name: 'Nhập môn hệ thống thông tin quản lý', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MIS211', name: 'Nghiên cứu vận trù', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP247', name: 'Lập trình căn bản', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP2101', name: 'Lập trình thực hành', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'COS212', name: 'Cơ sở dữ liệu căn bản', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'COS2015', name: 'Cơ sở dữ liệu thực hành', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'BUS113', name: 'Thống kê kinh doanh căn bản', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MIS115', name: 'Phân tích và mô hình hóa phát triển hệ thống thông tin kinh doanh', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAN154', name: 'Quản trị dự án hệ thống thông tin', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MIS107', name: 'Hệ thống thông tin quy trình kinh doanh và quản lý', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MIS221', name: 'Máy học căn bản bằng Python', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MIS222', name: 'Máy học trong phân tích dữ liệu', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'COS116', name: 'Phương pháp nghiên cứu trong khoa học dữ liệu', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MIS109', name: 'Mô hình hóa quy trình kinh doanh', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MIS114', name: 'Phân tích mô tả và dự báo', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MIS104', name: 'Hệ thống quản trị quan hệ khách hàng', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MIS105', name: 'Hệ thống thông tin kế toán', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MIS123', name: 'Kho dữ liệu và hệ thống hỗ trợ ra quyết định', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MIS402', name: 'Đồ án chuyên ngành hệ thống thông tin quản lý', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MIS5001', name: 'Hệ thống thông tin quản lý trong thực tiễn', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MIS5002', name: 'AI trong kinh doanh', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MIS103', name: 'Hệ thống hoạch định nguồn lực doanh nghiệp', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MIS1003', name: 'Bảo mật hệ thống thông tin', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MIS312', name: 'Phân tích dữ liệu hướng dự án', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MIS3004', name: 'Mô hình hóa và phân tích kinh doanh hướng dự án', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MIS516', name: 'Thực tập tốt nghiệp ngành Hệ thống thông tin quản lý', credits: 3, category: 'Chuyên nghiệp bắt buộc'});

// ────────────────────────────────────────────────────────────────
// II.2. KIẾN THỨC TỰ CHỌN (chọn 9 tín chỉ)
// ────────────────────────────────────────────────────────────────

// Nhóm 1: Khoá luận tốt nghiệp
MERGE (:Course {id: 'MIS4005', name: 'Khóa luận tốt nghiệp Hệ thống thông tin quản lý', credits: 9, category: 'Tự chọn - Khoá luận tốt nghiệp'});

// Nhóm 2: Chuyển đổi số
MERGE (:Course {id: 'BUS208', name: 'Thương mại điện tử', credits: 3, category: 'Tự chọn - Chuyển đổi số'});
MERGE (:Course {id: 'MAN1018', name: 'Tổng quan về logistics và quản trị chuỗi cung ứng', credits: 3, category: 'Tự chọn - Chuyển đổi số'});
MERGE (:Course {id: 'MAR146', name: 'Nguyên lý marketing', credits: 3, category: 'Tự chọn - Chuyển đổi số'});

// ────────────────────────────────────────────────────────────────
// III. KIẾN THỨC KHÔNG TÍCH LŨY
// ────────────────────────────────────────────────────────────────

// III.1. Giáo dục thể chất (5 tín chỉ)
MERGE (:Course {id: 'PHT304', name: 'Bóng chuyền 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT305', name: 'Bóng chuyền 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT306', name: 'Bóng chuyền 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT307', name: 'Bóng rổ 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT308', name: 'Bóng rổ 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT309', name: 'Bóng rổ 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT310', name: 'Thể hình - Thẩm mỹ 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT311', name: 'Thể hình - Thẩm mỹ 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT312', name: 'Thể hình - Thẩm mỹ 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT313', name: 'Vovinam 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT314', name: 'Vovinam 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT315', name: 'Vovinam 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT316', name: 'Bóng đá 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT317', name: 'Bóng đá 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT318', name: 'Bóng đá 3', credits: 1, category: 'Thể chất'});

// III.2. Giáo dục Quốc phòng và An ninh
MERGE (:Course {id: 'NDF108', name: 'Quốc phòng, an ninh 1', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF109', name: 'Quốc phòng, an ninh 2', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF210', name: 'Quốc phòng, an ninh 3', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF211', name: 'Quốc phòng, an ninh 4', credits: 0, category: 'Quốc phòng An ninh'});

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 3: LIÊN KẾT MÔN HỌC VỚI NGÀNH                        ║
// ╚══════════════════════════════════════════════════════════════╝
MATCH (c:Course), (m:Major {id: '7340405'})
WHERE c.id IN [
    'POS104', 'POS105', 'POS106', 'POS107', 'POS103', 'ENC120', 'ENC121', 'ENC122',
    'ENC123', 'AIT129', 'ENS192', 'LAW158', 'SKL115', 'SKL102', 'MAN116', 'ACC114',
    'MIS120', 'MIS211', 'CMP247', 'CMP2101', 'COS212', 'COS2015', 'BUS113', 'MIS115',
    'MAN154', 'MIS107', 'MIS221', 'MIS222', 'COS116', 'MIS109', 'MIS114', 'MIS104',
    'MIS105', 'MIS123', 'MIS402', 'MIS5001', 'MIS5002', 'MIS103', 'MIS1003', 'MIS312',
    'MIS3004', 'MIS516', 'MIS4005', 'BUS208', 'MAN1018', 'MAR146', 'PHT304', 'PHT305',
    'PHT306', 'PHT307', 'PHT308', 'PHT309', 'PHT310', 'PHT311', 'PHT312', 'PHT313',
    'PHT314', 'PHT315', 'PHT316', 'PHT317', 'PHT318', 'NDF108', 'NDF109', 'NDF210',
    'NDF211'
]
MERGE (c)-[:BELONGS_TO]->(m);

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 4: MÔN TIÊN QUYẾT (PREREQUISITE_FOR)                  ║
// ║  Chiều: (Môn phải học trước)-[:PREREQUISITE_FOR]->(Môn sau)  ║
// ╚══════════════════════════════════════════════════════════════╝

// --- Anh ngữ: chuỗi tiên quyết ---
MATCH (a:Course {id: 'ENC120'}), (b:Course {id: 'ENC121'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'ENC121'}), (b:Course {id: 'ENC122'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'ENC122'}), (b:Course {id: 'ENC123'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// --- Chuỗi học tập chuyên ngành ---
MATCH (a:Course {id: 'CMP2101'}), (b:Course {id: 'MIS115'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'MIS221'}), (b:Course {id: 'MIS222'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'BUS113'}), (b:Course {id: 'COS116'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'BUS113'}), (b:Course {id: 'MIS114'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'MIS107'}), (b:Course {id: 'MIS104'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'MIS107'}), (b:Course {id: 'MIS103'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'ACC114'}), (b:Course {id: 'MIS105'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'COS2015'}), (b:Course {id: 'MIS123'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'MAN154'}), (b:Course {id: 'MIS402'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'MIS114'}), (b:Course {id: 'MIS312'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'MIS109'}), (b:Course {id: 'MIS3004'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 5: MÔN SONG HÀNH (COREQUISITE_WITH)                  ║
// ║  Chiều: (Thực hành)-[:COREQUISITE_WITH]->(Lý thuyết)        ║
// ╚══════════════════════════════════════════════════════════════╝
MATCH (a:Course {id: 'CMP2101'}), (b:Course {id: 'CMP247'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'COS2015'}), (b:Course {id: 'COS212'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'MIS107'}), (b:Course {id: 'MIS115'}) MERGE (a)-[:COREQUISITE_WITH]->(b);


// === NGANH 13/18: Kiến trúc K25_Cypher.txt ===
// =============================================================================
// CHƯƠNG TRÌNH ĐÀO TẠO NGÀNH KIẾN TRÚC (7580101) - ĐẠI HỌC HUTECH
// Đối tượng áp dụng: Đại học hệ chính quy từ khóa tuyển sinh năm 2025
// Tổng khối lượng: 160 tín chỉ tích lũy + 5 tín chỉ không tích lũy
// =============================================================================

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 0: XÓA DỮ LIỆU CŨ (chạy 1 lần trước khi import)    ║
// ╚══════════════════════════════════════════════════════════════╝

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 1: TẠO NODE NGÀNH                                     ║
// ╚══════════════════════════════════════════════════════════════╝
MERGE (:Major {id: '7580101', name: 'Kiến trúc', university: 'HUTECH', total_credits: 160, non_accum_credits: 5});

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 2: TẠO TẤT CẢ NODE MÔN HỌC                           ║
// ╚══════════════════════════════════════════════════════════════╝

// ────────────────────────────────────────────────────────────────
// I. KIẾN THỨC GIÁO DỤC ĐẠI CƯƠNG (50 tín chỉ)
// ────────────────────────────────────────────────────────────────
MERGE (:Course {id: 'POS104', name: 'Triết học Mác - Lênin', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'POS105', name: 'Kinh tế chính trị Mác - Lênin', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS106', name: 'Chủ nghĩa xã hội khoa học', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS107', name: 'Lịch sử Đảng Cộng sản Việt Nam', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS103', name: 'Tư tưởng Hồ Chí Minh', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'ENC120', name: 'Anh ngữ 1', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC121', name: 'Anh ngữ 2', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC122', name: 'Anh ngữ 3', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC123', name: 'Anh ngữ 4', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'AIT129', name: 'Trí tuệ nhân tạo ứng dụng', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'LAW106', name: 'Pháp luật đại cương', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'SKL115', name: 'Tư duy thiết kế dự án', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'SKL116', name: 'Đổi mới sáng tạo và tư duy khởi nghiệp', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENS192', name: 'Phát triển bền vững', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'SOS101', name: 'Cơ sở văn hóa Việt Nam', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'PSY167', name: 'Tâm lý học ứng dụng', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'SKL122', name: 'Kỹ năng phát triển bản thân', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ARH160', name: 'Nhập môn ngành Kiến trúc', credits: 3, category: 'Đại cương'});

// ────────────────────────────────────────────────────────────────
// II.1. KIẾN THỨC CHUYÊN NGHIỆP BẮT BUỘC (98 tín chỉ)
// ────────────────────────────────────────────────────────────────
MERGE (:Course {id: 'ART231', name: 'Hình họa', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ART105', name: 'Hình học họa hình', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ARH1002', name: 'Cấu tạo kiến trúc công trình', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ARH1003', name: 'Công nghệ và vật liệu xây dựng', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ARH2004', name: 'Bố cục tạo hình trong kiến trúc', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ARH449', name: 'Đồ án chuyên đề kiến trúc', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ARH4005', name: 'Đồ án công trình công cộng', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ARH4006', name: 'Đồ án công trình giáo dục, y tế', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ARH4007', name: 'Đồ án công trình văn hóa, thể dục thể thao', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ARH4008', name: 'Đồ án công trình nhà biệt thự, nhà liên kế', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ARH4009', name: 'Đồ án công trình chung cư', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ARH434', name: 'Đồ án quy hoạch khu dân cư', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ARH4010', name: 'Đồ án thiết kế cảnh quan đô thị', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ARH4011', name: 'Đồ án thiết kế nội, ngoại thất công trình biệt thự', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ARH7012', name: 'Kiến tập di sản kiến trúc và đô thị', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ARH243', name: 'Kỹ thuật mô hình', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ARH246', name: 'Kỹ thuật thể hiện đồ án kiến trúc', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ARH1013', name: 'Lịch sử kiến trúc', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ARH2014', name: 'Nguyên lý thiết kế kiến trúc công trình công nghiệp', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ARH2027', name: 'Nguyên lý thiết kế kiến trúc công trình nhà công cộng', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ARH2015', name: 'Nguyên lý thiết kế kiến trúc công trình nhà ở', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'PHY110', name: 'Vật lý kiến trúc', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAN179', name: 'Quản lý dự án', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ARH2016', name: 'Nguyên lý quy hoạch và thiết kế đô thị', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ARH2017', name: 'Nguyên lý thiết kế kiến trúc cảnh quan', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ARH1018', name: 'Thiết kế nội, ngoại thất thông minh trong công trình', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ARH344', name: 'Thiết kế nhanh', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ARH1019', name: 'Chuyên đề thiết kế hồ sơ năng lực cá nhân', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CAP222', name: 'Tin học chuyên ngành kiến trúc, mỹ thuật 1', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CAP223', name: 'Tin học chuyên ngành kiến trúc, mỹ thuật 2', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CAP243', name: 'Tin học chuyên ngành kiến trúc', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ARH2020', name: 'Ứng dụng AI trong thiết kế trình bày kiến trúc', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ARH1021', name: 'Chuyên đề bảo tồn di sản kiến trúc', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ART120', name: 'Vẽ phối cảnh', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ARH5022', name: 'Thực tập vẽ ghi kiến trúc', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ARH5023', name: 'Thực tập chuyên ngành kiến trúc', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ARH552', name: 'Thực tập tốt nghiệp ngành Kiến trúc', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ARH437', name: 'Đồ án tốt nghiệp Kiến trúc', credits: 9, category: 'Chuyên nghiệp bắt buộc'});

// ────────────────────────────────────────────────────────────────
// II.2. KIẾN THỨC TỰ CHỌN (chọn 12 tín chỉ)
// ────────────────────────────────────────────────────────────────

// Nhóm 1: Kiến trúc công nghệ hiện đại
MERGE (:Course {id: 'ARH162', name: 'Kiến trúc công trình không gian lớn', credits: 3, category: 'Tự chọn - Kiến trúc công nghệ hiện đại'});
MERGE (:Course {id: 'ARH1024', name: 'Ứng dụng AI trong thiết kế ý tưởng kiến trúc công trình', credits: 3, category: 'Tự chọn - Kiến trúc công nghệ hiện đại'});
MERGE (:Course {id: 'CET1009', name: 'Hệ thống kỹ thuật công trình hiện đại', credits: 3, category: 'Tự chọn - Kiến trúc công nghệ hiện đại'});
MERGE (:Course {id: 'ARH4025', name: 'Đồ án tổng hợp công trình phức hợp', credits: 3, category: 'Tự chọn - Kiến trúc công nghệ hiện đại'});

// Nhóm 2: Kiến trúc bền vững
MERGE (:Course {id: 'ARH164', name: 'Kiến trúc xanh trong thiết kế công trình', credits: 3, category: 'Tự chọn - Kiến trúc bền vững'});
MERGE (:Course {id: 'ARH1026', name: 'Ứng dụng AI trong thiết kế ý tưởng kiến trúc bền vững', credits: 3, category: 'Tự chọn - Kiến trúc bền vững'});
MERGE (:Course {id: 'CET1010', name: 'Hệ thống kỹ thuật công trình hiệu quả năng lượng', credits: 3, category: 'Tự chọn - Kiến trúc bền vững'});
MERGE (:Course {id: 'ARH436', name: 'Đồ án tổng hợp kiến trúc sinh thái', credits: 3, category: 'Tự chọn - Kiến trúc bền vững'});

// ────────────────────────────────────────────────────────────────
// III. KIẾN THỨC KHÔNG TÍCH LŨY
// ────────────────────────────────────────────────────────────────

// III.1. Giáo dục thể chất (5 tín chỉ)
MERGE (:Course {id: 'PHT304', name: 'Bóng chuyền 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT305', name: 'Bóng chuyền 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT306', name: 'Bóng chuyền 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT307', name: 'Bóng rổ 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT308', name: 'Bóng rổ 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT309', name: 'Bóng rổ 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT310', name: 'Thể hình - Thẩm mỹ 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT311', name: 'Thể hình - Thẩm mỹ 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT312', name: 'Thể hình - Thẩm mỹ 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT313', name: 'Vovinam 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT314', name: 'Vovinam 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT315', name: 'Vovinam 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT316', name: 'Bóng đá 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT317', name: 'Bóng đá 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT318', name: 'Bóng đá 3', credits: 1, category: 'Thể chất'});

// III.2. Giáo dục Quốc phòng và An ninh
MERGE (:Course {id: 'NDF108', name: 'Quốc phòng, an ninh 1', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF109', name: 'Quốc phòng, an ninh 2', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF210', name: 'Quốc phòng, an ninh 3', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF211', name: 'Quốc phòng, an ninh 4', credits: 0, category: 'Quốc phòng An ninh'});

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 3: LIÊN KẾT MÔN HỌC VỚI NGÀNH                        ║
// ╚══════════════════════════════════════════════════════════════╝
MATCH (c:Course), (m:Major {id: '7580101'})
MERGE (c)-[:BELONGS_TO]->(m);

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 4: MÔN TIÊN QUYẾT (PREREQUISITE_FOR)                  ║
// ║  Chiều: (Môn phải học trước)-[:PREREQUISITE_FOR]->(Môn sau)  ║
// ╚══════════════════════════════════════════════════════════════╝

// --- Anh ngữ: chuỗi tiên quyết ---
MATCH (a:Course {id: 'ENC120'}), (b:Course {id: 'ENC121'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'ENC121'}), (b:Course {id: 'ENC122'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'ENC122'}), (b:Course {id: 'ENC123'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// --- Kỹ năng ---
MATCH (a:Course {id: 'SKL115'}), (b:Course {id: 'SKL116'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// --- Chuỗi Đồ án chuyên ngành ---
MATCH (a:Course {id: 'ARH2027'})
WITH a
MATCH (c:Course) WHERE c.id IN ['ARH4005', 'ARH4006', 'ARH4007']
MERGE (a)-[:PREREQUISITE_FOR]->(c);

MATCH (a:Course {id: 'ARH2015'})
WITH a
MATCH (c:Course) WHERE c.id IN ['ARH4008', 'ARH4009']
MERGE (a)-[:PREREQUISITE_FOR]->(c);

MATCH (a:Course {id: 'ARH2016'}), (b:Course {id: 'ARH434'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'ARH2017'}), (b:Course {id: 'ARH4010'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'ARH1018'}), (b:Course {id: 'ARH4011'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);


// === NGANH 14/18: Luật K25_Cypher.txt ===
// =============================================================================
// CHƯƠNG TRÌNH ĐÀO TẠO NGÀNH LUẬT (7380101) - ĐẠI HỌC HUTECH
// Đối tượng áp dụng: Đại học hệ chính quy từ khóa tuyển sinh năm 2025
// Tổng khối lượng: 125 tín chỉ tích lũy + 5 tín chỉ không tích lũy
// =============================================================================

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 0: XÓA DỮ LIỆU CŨ (chạy 1 lần trước khi import)    ║
// ╚══════════════════════════════════════════════════════════════╝

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 1: TẠO NODE NGÀNH                                     ║
// ╚══════════════════════════════════════════════════════════════╝
MERGE (:Major {id: '7380101', name: 'Luật', university: 'HUTECH', total_credits: 125, non_accum_credits: 5});

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 2: TẠO TẤT CẢ NODE MÔN HỌC                           ║
// ╚══════════════════════════════════════════════════════════════╝

// ────────────────────────────────────────────────────────────────
// I. KIẾN THỨC GIÁO DỤC ĐẠI CƯƠNG (44 tín chỉ)
// ────────────────────────────────────────────────────────────────
MERGE (:Course {id: 'POS104', name: 'Triết học Mác - Lênin', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'POS105', name: 'Kinh tế chính trị Mác - Lênin', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS106', name: 'Chủ nghĩa xã hội khoa học', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS107', name: 'Lịch sử Đảng Cộng sản Việt Nam', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS103', name: 'Tư tưởng Hồ Chí Minh', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'ENC120', name: 'Anh ngữ 1', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC121', name: 'Anh ngữ 2', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC122', name: 'Anh ngữ 3', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC123', name: 'Anh ngữ 4', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'AIT129', name: 'Trí tuệ nhân tạo ứng dụng', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENS192', name: 'Phát triển bền vững', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'SKL101', name: 'Khởi nghiệp', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'SKL115', name: 'Tư duy thiết kế dự án', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'PSY167', name: 'Tâm lý học ứng dụng', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'LOG101', name: 'Logic học', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'SOS102', name: 'Xã hội học', credits: 3, category: 'Đại cương'});

// ────────────────────────────────────────────────────────────────
// II.1. KIẾN THỨC CHUYÊN NGHIỆP BẮT BUỘC (72 tín chỉ)
// ────────────────────────────────────────────────────────────────
MERGE (:Course {id: 'LAW108', name: 'Lý luận về nhà nước và pháp luật', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'LAW110', name: 'Luật hiến pháp', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'LAW1018', name: 'Nghề luật và đạo đức nghề luật', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'LAW194', name: 'Kỹ thuật soạn thảo văn bản pháp luật', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'LAW111', name: 'Những vấn đề chung về luật dân sự', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'LAW115', name: 'Pháp luật về hợp đồng', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'LAW112', name: 'Luật hành chính', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'LAW1019', name: 'Pháp luật về giao dịch điện tử', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'LAW118', name: 'Luật thương mại', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'LAW120', name: 'Luật lao động', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'LAW121', name: 'Luật đất đai', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'LAW123', name: 'Luật hình sự', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'LAW127', name: 'Luật sở hữu trí tuệ', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'LAW160', name: 'Pháp luật về chủ thể kinh doanh', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'LAW129', name: 'Luật quốc tế', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'LAW264', name: 'Luật tố tụng hành chính', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'LAW267', name: 'Luật tố tụng dân sự', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'LAW268', name: 'Luật tố tụng hình sự', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'LAW180', name: 'Pháp luật về thuế', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'LAW181', name: 'Luật hôn nhân và gia đình', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'LAW117', name: 'Bồi thường thiệt hại ngoài hợp đồng', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'LAW188', name: 'Pháp luật về công chứng, chứng thực', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'LAW134', name: 'Luật đầu tư', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'LAW583', name: 'Thực tập tốt nghiệp ngành Luật', credits: 3, category: 'Chuyên nghiệp bắt buộc'});

// ────────────────────────────────────────────────────────────────
// II.2. KIẾN THỨC TỰ CHỌN (chọn 9 tín chỉ)
// ────────────────────────────────────────────────────────────────

// Nhóm 1
MERGE (:Course {id: 'LAW4020', name: 'Khóa luận tốt nghiệp Luật', credits: 9, category: 'Tự chọn - Nhóm 1'});

// Nhóm 2
MERGE (:Course {id: 'LAW196', name: 'Pháp luật về hòa giải và đối thoại', credits: 3, category: 'Tự chọn - Nhóm 2'});
MERGE (:Course {id: 'LAW186', name: 'Pháp luật về thanh tra, khiếu nại và tố cáo', credits: 3, category: 'Tự chọn - Nhóm 2'});
MERGE (:Course {id: 'LAW187', name: 'Pháp luật về giao dịch bảo đảm', credits: 3, category: 'Tự chọn - Nhóm 2'});

// ────────────────────────────────────────────────────────────────
// III. KIẾN THỨC KHÔNG TÍCH LŨY
// ────────────────────────────────────────────────────────────────

// III.1. Giáo dục thể chất (5 tín chỉ)
MERGE (:Course {id: 'PHT304', name: 'Bóng chuyền 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT305', name: 'Bóng chuyền 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT306', name: 'Bóng chuyền 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT307', name: 'Bóng rổ 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT308', name: 'Bóng rổ 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT309', name: 'Bóng rổ 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT310', name: 'Thể hình - Thẩm mỹ 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT311', name: 'Thể hình - Thẩm mỹ 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT312', name: 'Thể hình - Thẩm mỹ 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT313', name: 'Vovinam 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT314', name: 'Vovinam 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT315', name: 'Vovinam 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT316', name: 'Bóng đá 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT317', name: 'Bóng đá 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT318', name: 'Bóng đá 3', credits: 1, category: 'Thể chất'});

// III.2. Giáo dục Quốc phòng và An ninh
MERGE (:Course {id: 'NDF108', name: 'Quốc phòng, an ninh 1', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF109', name: 'Quốc phòng, an ninh 2', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF210', name: 'Quốc phòng, an ninh 3', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF211', name: 'Quốc phòng, an ninh 4', credits: 0, category: 'Quốc phòng An ninh'});

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 3: LIÊN KẾT MÔN HỌC VỚI NGÀNH                        ║
// ╚══════════════════════════════════════════════════════════════╝
MATCH (c:Course), (m:Major {id: '7380101'})
WHERE c.id IN [
    'POS104', 'POS105', 'POS106', 'POS107', 'POS103', 'ENC120', 'ENC121', 'ENC122',
    'ENC123', 'AIT129', 'ENS192', 'SKL101', 'SKL115', 'PSY167', 'LOG101', 'SOS102',
    'LAW108', 'LAW110', 'LAW1018', 'LAW194', 'LAW111', 'LAW115', 'LAW112', 'LAW1019',
    'LAW118', 'LAW120', 'LAW121', 'LAW123', 'LAW127', 'LAW160', 'LAW129', 'LAW264',
    'LAW267', 'LAW268', 'LAW180', 'LAW181', 'LAW117', 'LAW188', 'LAW134', 'LAW583',
    'LAW4020', 'LAW196', 'LAW186', 'LAW187', 'PHT304', 'PHT305', 'PHT306', 'PHT307',
    'PHT308', 'PHT309', 'PHT310', 'PHT311', 'PHT312', 'PHT313', 'PHT314', 'PHT315',
    'PHT316', 'PHT317', 'PHT318', 'NDF108', 'NDF109', 'NDF210', 'NDF211'
]
MERGE (c)-[:BELONGS_TO]->(m);

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 4: MÔN TIÊN QUYẾT (PREREQUISITE_FOR)                  ║
// ║  Chiều: (Môn phải học trước)-[:PREREQUISITE_FOR]->(Môn sau)  ║
// ╚══════════════════════════════════════════════════════════════╝

// --- Anh ngữ: chuỗi tiên quyết ---
MATCH (a:Course {id: 'ENC120'}), (b:Course {id: 'ENC121'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'ENC121'}), (b:Course {id: 'ENC122'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'ENC122'}), (b:Course {id: 'ENC123'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// --- Nền tảng Lý luận & Hiến pháp ---
MATCH (a:Course {id: 'LAW108'}), (b:Course {id: 'LAW111'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'LAW108'}), (b:Course {id: 'LAW112'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'LAW110'}), (b:Course {id: 'LAW111'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'LAW110'}), (b:Course {id: 'LAW112'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// --- Chuỗi Dân sự ---
MATCH (a:Course {id: 'LAW111'}), (b:Course {id: 'LAW115'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'LAW111'}), (b:Course {id: 'LAW267'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'LAW111'}), (b:Course {id: 'LAW181'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'LAW115'}), (b:Course {id: 'LAW117'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// --- Chuỗi Hành chính & Soạn thảo ---
MATCH (a:Course {id: 'LAW112'}), (b:Course {id: 'LAW194'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'LAW112'}), (b:Course {id: 'LAW264'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// --- Chuỗi Hình sự ---
MATCH (a:Course {id: 'LAW123'}), (b:Course {id: 'LAW268'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// --- Chuỗi Thương mại & Kinh doanh ---
MATCH (a:Course {id: 'LAW160'}), (b:Course {id: 'LAW118'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'LAW160'}), (b:Course {id: 'LAW180'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'LAW160'}), (b:Course {id: 'LAW134'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 5: MÔN SONG HÀNH (COREQUISITE_WITH)                  ║
// ║  Chiều: (Tự chọn)-[:COREQUISITE_WITH]->(Thực tập)           ║
// ╚══════════════════════════════════════════════════════════════╝
MATCH (a:Course {id: 'LAW4020'}), (b:Course {id: 'LAW583'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'LAW196'}), (b:Course {id: 'LAW583'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'LAW186'}), (b:Course {id: 'LAW583'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'LAW187'}), (b:Course {id: 'LAW583'}) MERGE (a)-[:COREQUISITE_WITH]->(b);


// === NGANH 15/18: Robot và trí tuệ nhân tạo K25_Cypher.txt ===
// =============================================================================
// CHƯƠNG TRÌNH ĐÀO TẠO NGÀNH ROBOT VÀ TRÍ TUỆ NHÂN TẠO (7510209) - ĐẠI HỌC HUTECH
// Đối tượng áp dụng: Đại học hệ chính quy từ khóa tuyển sinh năm 2025
// Tổng khối lượng: 150 tín chỉ tích lũy + 5 tín chỉ không tích lũy
// =============================================================================

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 0: XÓA DỮ LIỆU CŨ (chạy 1 lần trước khi import)    ║
// ╚══════════════════════════════════════════════════════════════╝

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 1: TẠO NODE NGÀNH                                     ║
// ╚══════════════════════════════════════════════════════════════╝
MERGE (:Major {id: '7510209', name: 'Robot và trí tuệ nhân tạo', university: 'HUTECH', total_credits: 150, non_accum_credits: 5});

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 2: TẠO TẤT CẢ NODE MÔN HỌC                           ║
// ╚══════════════════════════════════════════════════════════════╝

// ────────────────────────────────────────────────────────────────
// I. KIẾN THỨC GIÁO DỤC ĐẠI CƯƠNG (50 tín chỉ)
// ────────────────────────────────────────────────────────────────
MERGE (:Course {id: 'POS104', name: 'Triết học Mác - Lênin', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'POS105', name: 'Kinh tế chính trị Mác - Lênin', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS106', name: 'Chủ nghĩa xã hội khoa học', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS107', name: 'Lịch sử Đảng Cộng sản Việt Nam', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS103', name: 'Tư tưởng Hồ Chí Minh', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'ENC120', name: 'Anh ngữ 1', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC121', name: 'Anh ngữ 2', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC122', name: 'Anh ngữ 3', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC123', name: 'Anh ngữ 4', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'AIT129', name: 'Trí tuệ nhân tạo ứng dụng', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENS192', name: 'Phát triển bền vững', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'LAW106', name: 'Pháp luật đại cương', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'SKL115', name: 'Tư duy thiết kế dự án', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'SKL116', name: 'Đổi mới sáng tạo và tư duy khởi nghiệp', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'MAT101', name: 'Đại số tuyến tính', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'MAT118', name: 'Giải tích', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'PHY101', name: 'Vật lý cơ', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'CAP221', name: 'Tin học kỹ thuật', credits: 3, category: 'Đại cương'});

// ────────────────────────────────────────────────────────────────
// II.1. KIẾN THỨC CHUYÊN NGHIỆP BẮT BUỘC (85 tín chỉ)
// ────────────────────────────────────────────────────────────────
MERGE (:Course {id: 'MET653', name: 'Nhập môn ngành Robot và trí tuệ nhân tạo', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP2070', name: 'Lập trình Python', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ELE116', name: 'Kỹ thuật điện tử', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ELC5001', name: 'Thực tập kỹ thuật điện tử', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MET103', name: 'Cơ sở thiết kế máy', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MET2004', name: 'CAD trong kỹ thuật', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MET154', name: 'Các hệ thống máy tính điều khiển', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CTR5001', name: 'Thực tập các hệ thống máy tính điều khiển', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ELE170', name: 'Cảm biến và cơ cấu chấp hành', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CTR5002', name: 'Thực tập cảm biến và cơ cấu chấp hành', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ELE472', name: 'Đồ án cảm biến và cơ cấu chấp hành', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'COE1016', name: 'Lập trình nhúng và ứng dụng', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'COE5017', name: 'Thực tập lập trình hệ thống nhúng và ứng dụng', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CTR105', name: 'Lý thuyết điều khiển tự động', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'AIT4013', name: 'Đồ án ứng dụng ngành Robot và trí tuệ nhân tạo', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CTR222', name: 'Robot trong công nghiệp', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'AIT1014', name: 'ROS và điều khiển robot', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'AIT3015', name: 'Thực hành ROS và điều khiển robot', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MET287', name: 'Công nghệ IoT', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MET463', name: 'Đồ án IoT', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MET257', name: 'Thị giác máy tính và ứng dụng', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MET259', name: 'Máy học và ứng dụng', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MET161', name: 'Xử lý ảnh số', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MET189', name: 'Công nghệ tính toán mềm', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MET456', name: 'Đồ án robot', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CTR104', name: 'Lập trình PLC', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ELE128', name: 'SCADA', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP1010', name: 'Mạng truyền thông trong công nghiệp', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP104', name: 'Lập trình đồ họa', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'COE5018', name: 'Thực tập lập trình đồ họa', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MET466', name: 'Đồ án thị giác máy tính', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MET568', name: 'Thực tập tốt nghiệp ngành Robot và trí tuệ nhân tạo', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'AIT4016', name: 'Đồ án tốt nghiệp Robot và trí tuệ nhân tạo', credits: 9, category: 'Chuyên nghiệp bắt buộc'});

// ────────────────────────────────────────────────────────────────
// II.2. KIẾN THỨC TỰ CHỌN (chọn 15 tín chỉ)
// ────────────────────────────────────────────────────────────────

// Nhóm 1: Robot thông minh
MERGE (:Course {id: 'MET171', name: 'Robot di động', credits: 3, category: 'Tự chọn - Robot thông minh'});
MERGE (:Course {id: 'MET165', name: 'Học sâu và ứng dụng', credits: 3, category: 'Tự chọn - Robot thông minh'});
MERGE (:Course {id: 'CMP1072', name: 'Lập trình các thiết bị di động trong robot', credits: 3, category: 'Tự chọn - Robot thông minh'});
MERGE (:Course {id: 'AIT1017', name: 'Học tăng cường và ứng dụng', credits: 3, category: 'Tự chọn - Robot thông minh'});
MERGE (:Course {id: 'AIT1018', name: 'Định vị và xây dựng bản đồ trong robot', credits: 3, category: 'Tự chọn - Robot thông minh'});

// Nhóm 2: Dữ liệu và hệ thống
MERGE (:Course {id: 'MET170', name: 'Khai phá dữ liệu trong AI và robot', credits: 3, category: 'Tự chọn - Dữ liệu và hệ thống'});
MERGE (:Course {id: 'MET164', name: 'Dữ liệu lớn và ứng dụng', credits: 3, category: 'Tự chọn - Dữ liệu và hệ thống'});
MERGE (:Course {id: 'CMP1073', name: 'Lập trình web và ứng dụng', credits: 3, category: 'Tự chọn - Dữ liệu và hệ thống'});
MERGE (:Course {id: 'MET172', name: 'An toàn và bảo mật hệ thống', credits: 3, category: 'Tự chọn - Dữ liệu và hệ thống'});
MERGE (:Course {id: 'MET160', name: 'Cơ sở dữ liệu trong AI và robot', credits: 3, category: 'Tự chọn - Dữ liệu và hệ thống'});

// ────────────────────────────────────────────────────────────────
// III. KIẾN THỨC KHÔNG TÍCH LŨY
// ────────────────────────────────────────────────────────────────

// III.1. Giáo dục thể chất (5 tín chỉ)
MERGE (:Course {id: 'PHT304', name: 'Bóng chuyền 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT305', name: 'Bóng chuyền 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT306', name: 'Bóng chuyền 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT307', name: 'Bóng rổ 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT308', name: 'Bóng rổ 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT309', name: 'Bóng rổ 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT310', name: 'Thể hình - Thẩm mỹ 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT311', name: 'Thể hình - Thẩm mỹ 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT312', name: 'Thể hình - Thẩm mỹ 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT313', name: 'Vovinam 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT314', name: 'Vovinam 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT315', name: 'Vovinam 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT316', name: 'Bóng đá 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT317', name: 'Bóng đá 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT318', name: 'Bóng đá 3', credits: 1, category: 'Thể chất'});

// III.2. Giáo dục Quốc phòng và An ninh
MERGE (:Course {id: 'NDF108', name: 'Quốc phòng, an ninh 1', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF109', name: 'Quốc phòng, an ninh 2', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF210', name: 'Quốc phòng, an ninh 3', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF211', name: 'Quốc phòng, an ninh 4', credits: 0, category: 'Quốc phòng An ninh'});

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 3: LIÊN KẾT MÔN HỌC VỚI NGÀNH                        ║
// ╚══════════════════════════════════════════════════════════════╝
MATCH (c:Course), (m:Major {id: '7510209'})
MERGE (c)-[:BELONGS_TO]->(m);

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 4: MÔN TIÊN QUYẾT (PREREQUISITE_FOR)                  ║
// ║  Chiều: (Môn phải học trước)-[:PREREQUISITE_FOR]->(Môn sau)  ║
// ╚══════════════════════════════════════════════════════════════╝

// --- Anh ngữ: chuỗi tiên quyết ---
MATCH (a:Course {id: 'ENC120'}), (b:Course {id: 'ENC121'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'ENC121'}), (b:Course {id: 'ENC122'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'ENC122'}), (b:Course {id: 'ENC123'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// --- Kỹ năng & Đổi mới ---
MATCH (a:Course {id: 'SKL115'}), (b:Course {id: 'SKL116'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// --- Python làm nền tảng ---
MATCH (p:Course {id: 'CMP2070'})
WITH p
MATCH (c:Course) WHERE c.id IN ['MET154', 'MET161', 'MET165']
MERGE (p)-[:PREREQUISITE_FOR]->(c);

// --- Điện tử & Cảm biến ---
MATCH (a:Course {id: 'ELE116'})
WITH a
MATCH (c:Course) WHERE c.id IN ['ELE170', 'COE1016', 'CTR104', 'CMP104']
MERGE (a)-[:PREREQUISITE_FOR]->(c);

MATCH (a:Course {id: 'ELE170'}), (b:Course {id: 'ELE472'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// --- Điều khiển & Robot ---
MATCH (a:Course {id: 'CTR104'}), (b:Course {id: 'ELE128'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'CTR222'}), (b:Course {id: 'MET456'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'MET257'}), (b:Course {id: 'MET466'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 5: MÔN SONG HÀNH (COREQUISITE_WITH)                  ║
// ║  Chiều: (Thực hành/Đồ án)-[:COREQUISITE_WITH]->(Lý thuyết)  ║
// ╚══════════════════════════════════════════════════════════════╝
MATCH (a:Course {id: 'ELC5001'}), (b:Course {id: 'ELE116'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'CTR5001'}), (b:Course {id: 'MET154'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'CTR5002'}), (b:Course {id: 'ELE170'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'COE5017'}), (b:Course {id: 'COE1016'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'COE5018'}), (b:Course {id: 'CMP104'}) MERGE (a)-[:COREQUISITE_WITH]->(b);


// === NGANH 16/18: Thú y K25_Cypher.txt ===
// =============================================================================
// CHƯƠNG TRÌNH ĐÀO TẠO NGÀNH THÚ Y (7640101) - ĐẠI HỌC HUTECH
// Đối tượng áp dụng: Đại học hệ chính quy từ khóa tuyển sinh năm 2025
// Tổng khối lượng: 160 tín chỉ tích lũy + 5 tín chỉ không tích lũy
// =============================================================================

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 0: XÓA DỮ LIỆU CŨ (chạy 1 lần trước khi import)    ║
// ╚══════════════════════════════════════════════════════════════╝

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 1: TẠO NODE NGÀNH                                     ║
// ╚══════════════════════════════════════════════════════════════╝
MERGE (:Major {id: '7640101', name: 'Thú y', university: 'HUTECH', total_credits: 160, non_accum_credits: 5});

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 2: TẠO TẤT CẢ NODE MÔN HỌC                           ║
// ╚══════════════════════════════════════════════════════════════╝

// ────────────────────────────────────────────────────────────────
// I. KIẾN THỨC GIÁO DỤC ĐẠI CƯƠNG (48 tín chỉ)
// ────────────────────────────────────────────────────────────────
MERGE (:Course {id: 'POS104', name: 'Triết học Mác - Lênin', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'POS105', name: 'Kinh tế chính trị Mác - Lênin', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS106', name: 'Chủ nghĩa xã hội khoa học', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS107', name: 'Lịch sử Đảng Cộng sản Việt Nam', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS103', name: 'Tư tưởng Hồ Chí Minh', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'ENC120', name: 'Anh ngữ 1', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC121', name: 'Anh ngữ 2', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC122', name: 'Anh ngữ 3', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC123', name: 'Anh ngữ 4', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'AIT129', name: 'Trí tuệ nhân tạo ứng dụng', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENS192', name: 'Phát triển bền vững', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'LAW158', name: 'Luật và Khởi nghiệp', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'BIO191', name: 'Vi sinh cơ bản', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'SKL115', name: 'Tư duy thiết kế dự án', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'VET261', name: 'Động vật học', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'VET5001', name: 'Nhập môn thú y - chăn nuôi', credits: 1, category: 'Đại cương'});
MERGE (:Course {id: 'VET108', name: 'Tổ chức học động vật', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'BIO196', name: 'Sinh học phân tử', credits: 3, category: 'Đại cương'});

// ────────────────────────────────────────────────────────────────
// II.1. KIẾN THỨC CHUYÊN NGHIỆP BẮT BUỘC (103 tín chỉ)
// ────────────────────────────────────────────────────────────────
MERGE (:Course {id: 'VET102', name: 'Cơ thể học gia súc', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'VET104', name: 'Sinh lý gia súc', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'VET106', name: 'Dinh dưỡng động vật và thức ăn chăn nuôi', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'VET155', name: 'Luật chăn nuôi và luật thú y', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'VET142', name: 'Vi sinh bệnh động vật', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'VET111', name: 'Dược lý thú y', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'VET262', name: 'Chăm sóc và thẩm mỹ thú cưng', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'VET215', name: 'Giải phẫu bệnh thú y', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'VET148', name: 'Sinh lý bệnh động vật', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'VET145', name: 'Miễn dịch học thú y và vắc xin', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'VET4002', name: 'Một sức khoẻ', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAT122', name: 'Thống kê ứng dụng trong chăn nuôi - thú y', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'VET1003', name: 'Dịch tễ học thú y', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'VET150', name: 'Chăn nuôi gia cầm và heo', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'VET1004', name: 'Chăn nuôi gia súc ăn cỏ', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'VET244', name: 'Chẩn đoán lâm sàng thú y', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'VET1005', name: 'Chẩn đoán cận lâm sàng thú y', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'VET149', name: 'Bệnh nội khoa gia súc', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'VET220', name: 'Ngoại khoa gia súc', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'VET264', name: 'Sản khoa', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'VET124', name: 'Bệnh dinh dưỡng và độc chất học thú y', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'VET354', name: 'Thực hành ký sinh trùng động vật', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'VET153', name: 'Ký sinh trùng động vật', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'VET121', name: 'Bệnh truyền nhiễm chung và bệnh truyền nhiễm gia cầm', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'VET122', name: 'Bệnh truyền nhiễm gia súc', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'VET165', name: 'Bệnh chó mèo', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'BIO197', name: 'Ứng dụng công nghệ sinh học trong chăn nuôi - thú y', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'VET1006', name: 'Môi trường và an toàn sinh học', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'BIO167', name: 'Sinh hóa động vật', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'VET128', name: 'Kiểm nghiệm sản phẩm động vật', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'VET6013', name: 'Kỹ thuật chăm sóc và thẩm mỹ thú cưng nâng cao', credits: 3, category: 'Chuyên nghiệp bắt buộc'});

// Đồ án và Thực hành
MERGE (:Course {id: 'VET303', name: 'Thực hành cơ thể học gia súc', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'BIO368', name: 'Thực hành sinh hóa động vật', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'VET305', name: 'Thực hành sinh lý gia súc', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'VET343', name: 'Thực hành vi sinh bệnh động vật', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'VET312', name: 'Thực hành dược lý thú y', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAT323', name: 'Thực hành thống kê ứng dụng trong chăn nuôi - thú y', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'VET3007', name: 'Thực hành chẩn đoán xét nghiệm', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'VET3008', name: 'Thực hành chẩn đoán hình ảnh', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'VET5009', name: 'Thực tập thú y chăn nuôi 1', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'VET5010', name: 'Thực tập thú y chăn nuôi 2', credits: 3, category: 'Chuyên nghiệp bắt buộc'});

// ────────────────────────────────────────────────────────────────
// II.2. KIẾN THỨC TỰ CHỌN (chọn 9 tín chỉ)
// ────────────────────────────────────────────────────────────────

// Nhóm 1: Tiểu luận thú y
MERGE (:Course {id: 'VET4011', name: 'Tiểu luận thú y', credits: 3, category: 'Tự chọn - Tiểu luận thú y'});
MERGE (:Course {id: 'VET177', name: 'Dịch vụ thú y', credits: 3, category: 'Tự chọn - Tiểu luận thú y'});
MERGE (:Course {id: 'VET174', name: 'Bệnh thú hoang dã', credits: 3, category: 'Tự chọn - Tiểu luận thú y'});

// Nhóm 2: Đồ án tốt nghiệp
MERGE (:Course {id: 'VET4012', name: 'Khóa luận tốt nghiệp Thú y', credits: 9, category: 'Tự chọn - Đồ án tốt nghiệp'});

// ────────────────────────────────────────────────────────────────
// III. KIẾN THỨC KHÔNG TÍCH LŨY
// ────────────────────────────────────────────────────────────────

// III.1. Giáo dục thể chất (5 tín chỉ)
MERGE (:Course {id: 'PHT304', name: 'Bóng chuyền 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT305', name: 'Bóng chuyền 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT306', name: 'Bóng chuyền 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT307', name: 'Bóng rổ 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT308', name: 'Bóng rổ 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT309', name: 'Bóng rổ 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT310', name: 'Thể hình - Thẩm mỹ 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT311', name: 'Thể hình - Thẩm mỹ 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT312', name: 'Thể hình - Thẩm mỹ 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT313', name: 'Vovinam 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT314', name: 'Vovinam 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT315', name: 'Vovinam 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT316', name: 'Bóng đá 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT317', name: 'Bóng đá 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT318', name: 'Bóng đá 3', credits: 1, category: 'Thể chất'});

// III.2. Giáo dục Quốc phòng và An ninh
MERGE (:Course {id: 'NDF108', name: 'Quốc phòng, an ninh 1', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF109', name: 'Quốc phòng, an ninh 2', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF210', name: 'Quốc phòng, an ninh 3', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF211', name: 'Quốc phòng, an ninh 4', credits: 0, category: 'Quốc phòng An ninh'});

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 3: LIÊN KẾT MÔN HỌC VỚI NGÀNH                        ║
// ╚══════════════════════════════════════════════════════════════╝
MATCH (c:Course), (m:Major {id: '7640101'})
WHERE c.id IN [
    'POS104', 'POS105', 'POS106', 'POS107', 'POS103', 'ENC120', 'ENC121', 'ENC122',
    'ENC123', 'AIT129', 'ENS192', 'LAW158', 'BIO191', 'SKL115', 'VET261', 'VET5001',
    'VET108', 'BIO196', 'VET102', 'VET104', 'VET106', 'VET155', 'VET142', 'VET111',
    'VET262', 'VET215', 'VET148', 'VET145', 'VET4002', 'MAT122', 'VET1003', 'VET150',
    'VET1004', 'VET244', 'VET1005', 'VET149', 'VET220', 'VET264', 'VET124', 'VET354',
    'VET153', 'VET121', 'VET122', 'VET165', 'BIO197', 'VET1006', 'BIO167', 'VET128',
    'VET6013', 'VET303', 'BIO368', 'VET305', 'VET343', 'VET312', 'MAT323', 'VET3007',
    'VET3008', 'VET5009', 'VET5010', 'VET4011', 'VET177', 'VET174', 'VET4012', 'PHT304',
    'PHT305', 'PHT306', 'PHT307', 'PHT308', 'PHT309', 'PHT310', 'PHT311', 'PHT312',
    'PHT313', 'PHT314', 'PHT315', 'PHT316', 'PHT317', 'PHT318', 'NDF108', 'NDF109',
    'NDF210', 'NDF211'
]
MERGE (c)-[:BELONGS_TO]->(m);

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 4: MÔN TIÊN QUYẾT (PREREQUISITE_FOR)                  ║
// ║  Chiều: (Môn phải học trước)-[:PREREQUISITE_FOR]->(Môn sau)  ║
// ╚══════════════════════════════════════════════════════════════╝

// --- Anh ngữ: chuỗi tiên quyết ---
MATCH (a:Course {id: 'ENC120'}), (b:Course {id: 'ENC121'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'ENC121'}), (b:Course {id: 'ENC122'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'ENC122'}), (b:Course {id: 'ENC123'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 5: MÔN SONG HÀNH (COREQUISITE_WITH)                  ║
// ║  Chiều: (Thực hành/Đồ án)-[:COREQUISITE_WITH]->(Lý thuyết)  ║
// ╚══════════════════════════════════════════════════════════════╝
MATCH (a:Course {id: 'VET303'}), (b:Course {id: 'VET102'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'BIO368'}), (b:Course {id: 'BIO167'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'VET305'}), (b:Course {id: 'VET104'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'VET343'}), (b:Course {id: 'VET142'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'VET312'}), (b:Course {id: 'VET111'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'MAT323'}), (b:Course {id: 'MAT122'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'VET3007'}), (b:Course {id: 'VET1005'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'VET3008'}), (b:Course {id: 'VET1005'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'VET1005'}), (b:Course {id: 'VET244'}) MERGE (a)-[:COREQUISITE_WITH]->(b);


// === NGANH 17/18: Thương mại điện tử K25_Cypher.txt ===
// =============================================================================
// CHƯƠNG TRÌNH ĐÀO TẠO NGÀNH THƯƠNG MẠI ĐIỆN TỬ (7340122) - ĐẠI HỌC HUTECH
// Đối tượng áp dụng: Đại học hệ chính quy từ khóa tuyển sinh năm 2025
// Tổng khối lượng: 125 tín chỉ tích lũy + 5 tín chỉ không tích lũy
// =============================================================================

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 0: XÓA DỮ LIỆU CŨ (chạy 1 lần trước khi import)    ║
// ╚══════════════════════════════════════════════════════════════╝

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 1: TẠO NODE NGÀNH                                     ║
// ╚══════════════════════════════════════════════════════════════╝
MERGE (:Major {id: '7340122', name: 'Thương mại điện tử', university: 'HUTECH', total_credits: 125, non_accum_credits: 5});

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 2: TẠO TẤT CẢ NODE MÔN HỌC                           ║
// ╚══════════════════════════════════════════════════════════════╝

// ────────────────────────────────────────────────────────────────
// I. KIẾN THỨC GIÁO DỤC ĐẠI CƯƠNG (44 tín chỉ)
// ────────────────────────────────────────────────────────────────
MERGE (:Course {id: 'POS104', name: 'Triết học Mác - Lênin', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'POS105', name: 'Kinh tế chính trị Mác - Lênin', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS106', name: 'Chủ nghĩa xã hội khoa học', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS107', name: 'Lịch sử Đảng Cộng sản Việt Nam', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS103', name: 'Tư tưởng Hồ Chí Minh', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'ENC120', name: 'Anh ngữ 1', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC121', name: 'Anh ngữ 2', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC122', name: 'Anh ngữ 3', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC123', name: 'Anh ngữ 4', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'AIT129', name: 'Trí tuệ nhân tạo ứng dụng', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENS192', name: 'Phát triển bền vững', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'LAW158', name: 'Luật và Khởi nghiệp', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'SKL115', name: 'Tư duy thiết kế dự án', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'MDC187', name: 'Giao tiếp chuyên nghiệp', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'MAN116', name: 'Quản trị học', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'PSY167', name: 'Tâm lý học ứng dụng', credits: 3, category: 'Đại cương'});

// ────────────────────────────────────────────────────────────────
// II.1. KIẾN THỨC CHUYÊN NGHIỆP BẮT BUỘC (72 tín chỉ)
// ────────────────────────────────────────────────────────────────
MERGE (:Course {id: 'ECO117', name: 'Kinh tế học', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ECO241', name: 'Phương pháp nghiên cứu kinh tế', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FIN2017', name: 'Thuế', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'FIN1018', name: 'Tài chính xanh và phát triển bền vững', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'BUS1009', name: 'ESG và đạo đức kinh doanh', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'BUS130', name: 'Thống kê kinh doanh và phân tích dữ liệu', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MIS118', name: 'Hệ thống thông tin quản trị trong kinh doanh', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAR137', name: 'Tiếp thị và bán hàng trực tuyến', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'BUS129', name: 'Hành vi khách hàng trong kỹ thuật số', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'BUS1014', name: 'Thanh toán số', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAN1070', name: 'Quản trị tác nghiệp thương mại điện tử', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'MAN1005', name: 'Quản trị dự án thương mại điện tử', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'BUS1010', name: 'Thương mại điện tử và chuyển đổi số', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'LAW1014', name: 'Cơ sở pháp lý trong thương mại điện tử', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'BUS2011', name: 'Phân tích dữ liệu trong kinh doanh', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CIS1007', name: 'Xây dựng web kinh doanh trực tuyến', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CIS2008', name: 'Phát triển ứng dụng thương mại điện tử', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'BUS1012', name: 'Thương mại điện tử xuyên biên giới', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ACC154', name: 'Kế toán trong kinh doanh', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'BUS133', name: 'Thương mại trên mạng xã hội', credits: 3, category: 'Chuyên nghiệp bắt buộc'});

// Đồ án và Thực hành
MERGE (:Course {id: 'ECO444', name: 'Đồ án tác nghiệp thương mại điện tử', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ECO345', name: 'Thực hành kinh doanh trên nền tảng kỹ thuật số', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CIS3009', name: 'Thực hành xây dựng web kinh doanh trực tuyến', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ECO440', name: 'Đồ án nghiên cứu trong kinh tế', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'BUS457', name: 'Đồ án hệ thống thông tin quản trị trong kinh doanh', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ECO428', name: 'Đồ án chuyên ngành Thương mại điện tử', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ECO546', name: 'Dự án doanh nghiệp ngành Thương mại điện tử', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'ECO529', name: 'Thực tập tốt nghiệp ngành Thương mại điện tử', credits: 3, category: 'Chuyên nghiệp bắt buộc'});

// ────────────────────────────────────────────────────────────────
// II.2. KIẾN THỨC TỰ CHỌN (chọn 9 tín chỉ)
// ────────────────────────────────────────────────────────────────

// Nhóm 1: Chuyên sâu công nghệ
MERGE (:Course {id: 'MDC1001', name: 'Thiết kế trải nghiệm và giao diện người dùng', credits: 3, category: 'Tự chọn - Thương mại điện tử'});
MERGE (:Course {id: 'ECO143', name: 'Thương mại di động', credits: 3, category: 'Tự chọn - Thương mại điện tử'});
MERGE (:Course {id: 'FIN1025', name: 'Blockchain và thương mại điện tử', credits: 3, category: 'Tự chọn - Thương mại điện tử'});

// Nhóm 2: Khoá luận tốt nghiệp
MERGE (:Course {id: 'ECO4015', name: 'Khóa luận tốt nghiệp Thương mại điện tử', credits: 9, category: 'Tự chọn - Khoá luận tốt nghiệp'});

// ────────────────────────────────────────────────────────────────
// III. KIẾN THỨC KHÔNG TÍCH LŨY
// ────────────────────────────────────────────────────────────────

// III.1. Giáo dục thể chất (5 tín chỉ)
MERGE (:Course {id: 'PHT304', name: 'Bóng chuyền 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT305', name: 'Bóng chuyền 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT306', name: 'Bóng chuyền 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT307', name: 'Bóng rổ 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT308', name: 'Bóng rổ 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT309', name: 'Bóng rổ 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT310', name: 'Thể hình - Thẩm mỹ 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT311', name: 'Thể hình - Thẩm mỹ 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT312', name: 'Thể hình - Thẩm mỹ 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT313', name: 'Vovinam 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT314', name: 'Vovinam 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT315', name: 'Vovinam 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT316', name: 'Bóng đá 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT317', name: 'Bóng đá 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT318', name: 'Bóng đá 3', credits: 1, category: 'Thể chất'});

// III.2. Giáo dục Quốc phòng và An ninh
MERGE (:Course {id: 'NDF108', name: 'Quốc phòng, an ninh 1', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF109', name: 'Quốc phòng, an ninh 2', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF210', name: 'Quốc phòng, an ninh 3', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF211', name: 'Quốc phòng, an ninh 4', credits: 0, category: 'Quốc phòng An ninh'});

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 3: LIÊN KẾT MÔN HỌC VỚI NGÀNH                        ║
// ╚══════════════════════════════════════════════════════════════╝
MATCH (c:Course), (m:Major {id: '7340122'})
MERGE (c)-[:BELONGS_TO]->(m);

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 4: MÔN TIÊN QUYẾT (PREREQUISITE_FOR)                  ║
// ║  Chiều: (Môn phải học trước)-[:PREREQUISITE_FOR]->(Môn sau)  ║
// ╚══════════════════════════════════════════════════════════════╝

// --- Anh ngữ: chuỗi tiên quyết ---
MATCH (a:Course {id: 'ENC120'}), (b:Course {id: 'ENC121'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'ENC121'}), (b:Course {id: 'ENC122'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'ENC122'}), (b:Course {id: 'ENC123'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// --- Chuỗi học tập chuyên ngành ---
MATCH (a:Course {id: 'ECO117'}), (b:Course {id: 'BUS129'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'MAN1070'}), (b:Course {id: 'ECO444'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'CIS1007'}), (b:Course {id: 'CIS3009'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'ECO241'}), (b:Course {id: 'ECO440'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'MIS118'}), (b:Course {id: 'BUS457'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

MATCH (a:Course {id: 'MAN1005'})
WITH a
MATCH (c:Course) WHERE c.id IN ['ECO428', 'MDC1001', 'ECO143', 'FIN1025']
MERGE (a)-[:PREREQUISITE_FOR]->(c);

MATCH (a:Course {id: 'ECO428'})
WITH a
MATCH (c:Course) WHERE c.id IN ['ECO546', 'ECO529']
MERGE (a)-[:PREREQUISITE_FOR]->(c);

// Tiên quyết cho khóa luận
MATCH (p1:Course {id: 'MAN1005'}), (p2:Course {id: 'ECO428'}), (target:Course {id: 'ECO4015'})
MERGE (p1)-[:PREREQUISITE_FOR]->(target)
MERGE (p2)-[:PREREQUISITE_FOR]->(target);

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 5: MÔN SONG HÀNH (COREQUISITE_WITH)                  ║
// ║  Chiều: (Thực hành)-[:COREQUISITE_WITH]->(Lý thuyết)        ║
// ╚══════════════════════════════════════════════════════════════╝
MATCH (a:Course {id: 'ECO345'}), (b:Course {id: 'MAN1005'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'ECO529'}), (b:Course {id: 'ECO345'}) MERGE (a)-[:COREQUISITE_WITH]->(b);


// === NGANH 18/18: Trí tuệ nhân tạo K25_Cypher.txt ===
// =============================================================================
// CHƯƠNG TRÌNH ĐÀO TẠO NGÀNH TRÍ TUỆ NHÂN TẠO (7480107) - ĐẠI HỌC HUTECH
// Đối tượng áp dụng: Đại học hệ chính quy từ khóa tuyển sinh năm 2025
// Tổng khối lượng: 150 tín chỉ tích lũy + 5 tín chỉ không tích lũy
// =============================================================================

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 0: XÓA DỮ LIỆU CŨ (chạy 1 lần trước khi import)    ║
// ╚══════════════════════════════════════════════════════════════╝

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 1: TẠO NODE NGÀNH                                     ║
// ╚══════════════════════════════════════════════════════════════╝
MERGE (:Major {id: '7480107', name: 'Trí tuệ nhân tạo', university: 'HUTECH', total_credits: 150, non_accum_credits: 5});

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 2: TẠO TẤT CẢ NODE MÔN HỌC                           ║
// ╚══════════════════════════════════════════════════════════════╝

// ────────────────────────────────────────────────────────────────
// I. KIẾN THỨC GIÁO DỤC ĐẠI CƯƠNG (50 tín chỉ)
// ────────────────────────────────────────────────────────────────
MERGE (:Course {id: 'POS104', name: 'Triết học Mác - Lênin', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'POS105', name: 'Kinh tế chính trị Mác - Lênin', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS106', name: 'Chủ nghĩa xã hội khoa học', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS107', name: 'Lịch sử Đảng Cộng sản Việt Nam', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'POS103', name: 'Tư tưởng Hồ Chí Minh', credits: 2, category: 'Đại cương'});
MERGE (:Course {id: 'ENC120', name: 'Anh ngữ 1', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC121', name: 'Anh ngữ 2', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC122', name: 'Anh ngữ 3', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENC123', name: 'Anh ngữ 4', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'ENS192', name: 'Phát triển bền vững', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'LAW106', name: 'Pháp luật đại cương', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'SKL115', name: 'Tư duy thiết kế dự án', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'SKL116', name: 'Đổi mới sáng tạo và tư duy khởi nghiệp', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'AIT630', name: 'Nhập môn ngành Trí tuệ nhân tạo', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'MAT101', name: 'Đại số tuyến tính', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'MAT118', name: 'Giải tích', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'MAT105', name: 'Xác suất thống kê', credits: 3, category: 'Đại cương'});
MERGE (:Course {id: 'MAT104', name: 'Toán rời rạc', credits: 3, category: 'Đại cương'});

// ────────────────────────────────────────────────────────────────
// II.1. KIẾN THỨC CHUYÊN NGHIỆP BẮT BUỘC (91 tín chỉ)
// ────────────────────────────────────────────────────────────────
MERGE (:Course {id: 'CMP1074', name: 'Cơ sở lập trình', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP164', name: 'Kỹ thuật lập trình', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP167', name: 'Lập trình hướng đối tượng', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'COS135', name: 'Nhập môn cơ sở dữ liệu', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'COS1002', name: 'Các hệ quản trị cơ sở dữ liệu', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'COS120', name: 'Cấu trúc dữ liệu và giải thuật', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'COS129', name: 'Điện toán đám mây', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'AIT103', name: 'Lập trình cho trí tuệ nhân tạo', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP177', name: 'Lập trình trên thiết bị di động', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP175', name: 'Lập trình web', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP172', name: 'Mạng máy tính', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'AIT1001', name: 'Cơ sở trí tuệ nhân tạo', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'AIT104', name: 'Máy học', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP1020', name: 'Học sâu', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'AIT109', name: 'Xử lý ngôn ngữ tự nhiên và ứng dụng', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP1059', name: 'Phân tích dữ liệu lớn', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'AIT108', name: 'Xử lý ảnh và ứng dụng', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'AIT110', name: 'Phương pháp toán cho trí tuệ nhân tạo', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'AIT111', name: 'Các công cụ ứng dụng cho trí tuệ nhân tạo', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'AIT1009', name: 'Các phương pháp tối ưu cho trí tuệ nhân tạo', credits: 3, category: 'Chuyên nghiệp bắt buộc'});

// Đồ án và Thực hành
MERGE (:Course {id: 'COS321', name: 'Thực hành cấu trúc dữ liệu và giải thuật', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'COS323', name: 'Thực hành cơ sở dữ liệu', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP3075', name: 'Thực hành Cơ sở lập trình', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP365', name: 'Thực hành kỹ thuật lập trình', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP368', name: 'Thực hành lập trình hướng đối tượng', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP376', name: 'Thực hành lập trình Web', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP3014', name: 'Thực hành lý thuyết đồ thị', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP373', name: 'Thực hành mạng máy tính', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'CMP5089', name: 'Thực tập điện toán đám mây', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'AIT305', name: 'Thực hành lập trình cho trí tuệ nhân tạo', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'AIT312', name: 'Thực hành phương pháp toán cho trí tuệ nhân tạo', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'AIT313', name: 'Thực hành các công cụ ứng dụng cho trí tuệ nhân tạo', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'COS324', name: 'Thực hành quản trị cơ sở dữ liệu', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'AIT3010', name: 'Thực hành cơ sở trí tuệ nhân tạo', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'AIT306', name: 'Thực hành máy học', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'AIT315', name: 'Thực hành học sâu', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'AIT316', name: 'Thực hành xử lý ngôn ngữ tự nhiên và ứng dụng', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'AIT317', name: 'Thực hành phân tích dữ liệu lớn', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'AIT307', name: 'Thực hành xử lý ảnh và ứng dụng', credits: 1, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'AIT1002', name: 'Nghệ thuật lập trình với hỗ trợ trí tuệ nhân tạo', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'AIT5011', name: 'Thực tập cơ sở ngành trí tuệ nhân tạo', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'AIT419', name: 'Đồ án chuyên ngành trí tuệ nhân tạo', credits: 3, category: 'Chuyên nghiệp bắt buộc'});
MERGE (:Course {id: 'AIT520', name: 'Thực tập tốt nghiệp ngành Trí tuệ nhân tạo', credits: 3, category: 'Chuyên nghiệp bắt buộc'});

// ────────────────────────────────────────────────────────────────
// II.2. KIẾN THỨC TỰ CHỌN (chọn 9 tín chỉ)
// ────────────────────────────────────────────────────────────────

// Nhóm 1: Xử lý ngôn ngữ lớn
MERGE (:Course {id: 'AIT121', name: 'Truy vấn thông tin', credits: 3, category: 'Tự chọn - Xử lý ngôn ngữ lớn'});
MERGE (:Course {id: 'AIT122', name: 'Trí tuệ nhân tạo tạo sinh', credits: 3, category: 'Tự chọn - Xử lý ngôn ngữ lớn'});
MERGE (:Course {id: 'AIT123', name: 'Mô hình ngôn ngữ lớn', credits: 3, category: 'Tự chọn - Xử lý ngôn ngữ lớn'});

// Nhóm 2: Máy học và thị giác máy tính
MERGE (:Course {id: 'AIT125', name: 'Máy học nâng cao', credits: 3, category: 'Tự chọn - Máy học & Thị giác máy tính'});
MERGE (:Course {id: 'AIT1008', name: 'Phân tích ảnh và thị giác máy tính', credits: 3, category: 'Tự chọn - Máy học & Thị giác máy tính'});
MERGE (:Course {id: 'AIT127', name: 'Sinh trắc học', credits: 3, category: 'Tự chọn - Máy học & Thị giác máy tính'});

// Nhóm 3: Đồ án tốt nghiệp
MERGE (:Course {id: 'AIT4012', name: 'Đồ án tốt nghiệp Trí tuệ nhân tạo', credits: 9, category: 'Tự chọn - Đồ án tốt nghiệp'});

// ────────────────────────────────────────────────────────────────
// III. KIẾN THỨC KHÔNG TÍCH LŨY
// ────────────────────────────────────────────────────────────────

// III.1. Giáo dục thể chất (5 tín chỉ)
MERGE (:Course {id: 'PHT304', name: 'Bóng chuyền 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT305', name: 'Bóng chuyền 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT306', name: 'Bóng chuyền 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT307', name: 'Bóng rổ 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT308', name: 'Bóng rổ 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT309', name: 'Bóng rổ 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT310', name: 'Thể hình - Thẩm mỹ 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT311', name: 'Thể hình - Thẩm mỹ 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT312', name: 'Thể hình - Thẩm mỹ 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT313', name: 'Vovinam 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT314', name: 'Vovinam 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT315', name: 'Vovinam 3', credits: 1, category: 'Thể chất'});
MERGE (:Course {id: 'PHT316', name: 'Bóng đá 1', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT317', name: 'Bóng đá 2', credits: 2, category: 'Thể chất'});
MERGE (:Course {id: 'PHT318', name: 'Bóng đá 3', credits: 1, category: 'Thể chất'});

// III.2. Giáo dục Quốc phòng và An ninh
MERGE (:Course {id: 'NDF108', name: 'Quốc phòng, an ninh 1', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF109', name: 'Quốc phòng, an ninh 2', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF210', name: 'Quốc phòng, an ninh 3', credits: 0, category: 'Quốc phòng An ninh'});
MERGE (:Course {id: 'NDF211', name: 'Quốc phòng, an ninh 4', credits: 0, category: 'Quốc phòng An ninh'});

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 3: LIÊN KẾT MÔN HỌC VỚI NGÀNH                        ║
// ╚══════════════════════════════════════════════════════════════╝
MATCH (c:Course), (m:Major {id: '7480107'})
WHERE c.id IN [
    'POS104', 'POS105', 'POS106', 'POS107', 'POS103', 'ENC120', 'ENC121', 'ENC122',
    'ENC123', 'ENS192', 'LAW106', 'SKL115', 'SKL116', 'AIT630', 'MAT101', 'MAT118',
    'MAT105', 'MAT104', 'CMP1074', 'CMP164', 'CMP167', 'COS135', 'COS1002', 'COS120',
    'COS129', 'AIT103', 'CMP177', 'CMP175', 'CMP172', 'AIT1001', 'AIT104', 'CMP1020',
    'AIT109', 'CMP1059', 'AIT108', 'AIT110', 'AIT111', 'AIT1009', 'COS321', 'COS323',
    'CMP3075', 'CMP365', 'CMP368', 'CMP376', 'CMP3014', 'CMP373', 'CMP5089', 'AIT305',
    'AIT312', 'AIT313', 'COS324', 'AIT3010', 'AIT306', 'AIT315', 'AIT316', 'AIT317',
    'AIT307', 'AIT1002', 'AIT5011', 'AIT419', 'AIT520', 'AIT121', 'AIT122', 'AIT123',
    'AIT125', 'AIT1008', 'AIT127', 'AIT4012', 'PHT304', 'PHT305', 'PHT306', 'PHT307',
    'PHT308', 'PHT309', 'PHT310', 'PHT311', 'PHT312', 'PHT313', 'PHT314', 'PHT315',
    'PHT316', 'PHT317', 'PHT318', 'NDF108', 'NDF109', 'NDF210', 'NDF211'
]
MERGE (c)-[:BELONGS_TO]->(m);

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 4: MÔN TIÊN QUYẾT (PREREQUISITE_FOR)                  ║
// ║  Chiều: (Môn phải học trước)-[:PREREQUISITE_FOR]->(Môn sau)  ║
// ╚══════════════════════════════════════════════════════════════╝

// --- Anh ngữ: chuỗi tiên quyết ---
MATCH (a:Course {id: 'ENC120'}), (b:Course {id: 'ENC121'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'ENC121'}), (b:Course {id: 'ENC122'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'ENC122'}), (b:Course {id: 'ENC123'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// --- Kỹ năng ---
MATCH (a:Course {id: 'SKL115'}), (b:Course {id: 'SKL116'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// --- Chuỗi Lập trình & Thuật toán ---
MATCH (a:Course {id: 'CMP1074'}), (b:Course {id: 'CMP164'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'CMP164'}), (b:Course {id: 'COS120'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'CMP167'}), (b:Course {id: 'CMP177'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);
MATCH (a:Course {id: 'CMP167'}), (b:Course {id: 'CMP175'}) MERGE (a)-[:PREREQUISITE_FOR]->(b);

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 5: MÔN SONG HÀNH (COREQUISITE_WITH)                  ║
// ║  Chiều: (Thực hành)-[:COREQUISITE_WITH]->(Lý thuyết)        ║
// ╚══════════════════════════════════════════════════════════════╝
MATCH (a:Course {id: 'COS321'}), (b:Course {id: 'COS120'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'COS323'}), (b:Course {id: 'COS135'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'CMP3075'}), (b:Course {id: 'CMP1074'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'CMP365'}), (b:Course {id: 'CMP164'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'CMP368'}), (b:Course {id: 'CMP167'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'CMP376'}), (b:Course {id: 'CMP175'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'CMP373'}), (b:Course {id: 'CMP172'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'CMP5089'}), (b:Course {id: 'COS129'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'AIT305'}), (b:Course {id: 'AIT103'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'AIT312'}), (b:Course {id: 'AIT110'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'AIT313'}), (b:Course {id: 'AIT111'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'COS324'}), (b:Course {id: 'COS1002'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'AIT3010'}), (b:Course {id: 'AIT1001'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'AIT306'}), (b:Course {id: 'AIT104'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'AIT315'}), (b:Course {id: 'CMP1020'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'AIT316'}), (b:Course {id: 'AIT109'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'AIT317'}), (b:Course {id: 'CMP1059'}) MERGE (a)-[:COREQUISITE_WITH]->(b);
MATCH (a:Course {id: 'AIT307'}), (b:Course {id: 'AIT108'}) MERGE (a)-[:COREQUISITE_WITH]->(b);


// === NODE TRUONG DAI HOC + LIEN KET OFFERS ===
// =============================================================================
// THÔNG TIN TRƯỜNG ĐẠI HỌC VÀ LIÊN KẾT CÁC NGÀNH ĐÀO TẠO
// Hệ thống: EduGuide_VN
// Node gốc giúp AI trả lời về danh sách các ngành đào tạo của trường
// =============================================================================

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 1: TẠO NODE TRƯỜNG ĐẠI HỌC                             ║
// ╚══════════════════════════════════════════════════════════════╝
MERGE (u:University {
    id: 'HUTECH', 
    name: 'Trường Đại học Công nghệ TP.HCM', 
    abbreviation: 'HUTECH', 
    address: '475A Điện Biên Phủ, P.25, Q.Bình Thạnh, TP.HCM',
    website: 'https://www.hutech.edu.vn'
});

// ╔══════════════════════════════════════════════════════════════╗
// ║  PHẦN 2: LIÊN KẾT TẤT CẢ CÁC NGÀNH VỚI TRƯỜNG                ║
// ╚══════════════════════════════════════════════════════════════╝
// Câu lệnh này sẽ tự động tìm tất cả các Major có thuộc tính university là 'HUTECH'
// và tạo quan hệ OFFERS (Cung cấp/Đào tạo) từ node Trường đến node Ngành.

MATCH (u:University {id: 'HUTECH'})
MATCH (m:Major)
WHERE m.university = 'HUTECH'
MERGE (u)-[:OFFERS]->(m);

// ╔══════════════════════════════════════════════════════════════╗
// ║  DANH SÁCH CÁC MÃ NGÀNH ĐÃ ĐƯỢC LIÊN KẾT (18 Ngành)          ║
// ╚══════════════════════════════════════════════════════════════╝
// 1.  7480201 - Công nghệ thông tin
// 2.  7580302 - Quản lý xây dựng
// 3.  7340412 - Quản trị sự kiện
// 4.  7210404 - Thiết kế thời trang
// 5.  7340115 - Marketing
// 6.  7210205 - Thanh nhạc
// 7.  7310401 - Tâm lý học
// 8.  7510605 - Logistics và quản lý chuỗi cung ứng
// 9.  7340301 - Kế toán
// 10. 7540101 - Công nghệ thực phẩm
// 11. 7380101 - Luật
// 12. 7510209 - Robot và trí tuệ nhân tạo
// 13. 7640101 - Thú y
// 14. 7340405 - Hệ thống thông tin quản lý
// 15. 7480107 - Trí tuệ nhân tạo
// 16. 7580101 - Kiến trúc
// 17. 7480202 - An toàn thông tin
// 18. 7340122 - Thương mại điện tử

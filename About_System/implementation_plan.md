# Kế hoạch Đa ngôn ngữ (Anh/Việt) cho Admin Dashboard

Hệ thống hiện tại chưa có thiết lập đa ngôn ngữ (Internationalization - i18n). Để có thể chuyển đổi linh hoạt 100% giữa Tiếng Anh và Tiếng Việt cho trang Quản trị, tôi sẽ thiết lập thư viện chuẩn `react-i18next` và thay thế toàn bộ văn bản cứng (hardcoded text) thành các biến ngôn ngữ.

> [!IMPORTANT]
> Cần phản hồi (User Review Required):
> - Tôi sẽ thiết lập cấu trúc đa ngôn ngữ cho **toàn bộ Frontend**, nhưng trước mắt sẽ chỉ dịch (translate) các trang trong mục **Admin Dashboard** (Overview, Users, Analytics, Knowledge Base) như bạn yêu cầu. Bạn có muốn tôi dịch luôn giao diện Chatbot ở bên ngoài không, hay chỉ cần tập trung vào Admin trước?
> - Thiết kế Nút chuyển đổi (Language Toggle): Tôi dự định đặt nút này ở góc trên bên phải của trang Admin hoặc dưới cùng của thanh Sidebar. Bạn thích vị trí nào hơn?

## Proposed Changes

---

### Cài đặt Thư viện
Thêm các thư viện cần thiết cho việc dịch thuật.

#### [NEW] Dependencies
- Cài đặt `i18next` và `react-i18next` (Sẽ chạy lệnh `bun install i18next react-i18next`).

---

### Cấu hình Đa ngôn ngữ (i18n Setup)
Tạo cấu trúc file chứa từ điển dịch thuật và khởi tạo hệ thống i18n.

#### [NEW] [src/i18n.ts](file:///d:/DEV_KnowLedge/Done_Project/EduGuide_VN/ChatBoxAI_Educational/frontend/src/i18n.ts)
- Khởi tạo cấu hình i18next.
- Cấu hình ngôn ngữ mặc định (Tiếng Việt hoặc Tiếng Anh).
- Lưu trữ lựa chọn ngôn ngữ của người dùng vào `localStorage` để ghi nhớ cho lần đăng nhập sau.

#### [NEW] [src/locales/en.json](file:///d:/DEV_KnowLedge/Done_Project/EduGuide_VN/ChatBoxAI_Educational/frontend/src/locales/en.json)
- Chứa toàn bộ các chuỗi văn bản Tiếng Anh (ví dụ: `"total_users": "Total Users"`).

#### [NEW] [src/locales/vi.json](file:///d:/DEV_KnowLedge/Done_Project/EduGuide_VN/ChatBoxAI_Educational/frontend/src/locales/vi.json)
- Chứa toàn bộ các chuỗi văn bản Tiếng Việt (ví dụ: `"total_users": "Tổng số Người dùng"`).

#### [MODIFY] [src/main.tsx](file:///d:/DEV_KnowLedge/Done_Project/EduGuide_VN/ChatBoxAI_Educational/frontend/src/main.tsx)
- Import `src/i18n.ts` vào file gốc để kích hoạt hệ thống ngôn ngữ khi app khởi động.

---

### Nút chuyển đổi Ngôn ngữ (UI Component)
Tạo nút bấm để người dùng có thể chuyển qua lại giữa Anh/Việt.

#### [NEW] [src/components/Common/LanguageSwitcher.tsx](file:///d:/DEV_KnowLedge/Done_Project/EduGuide_VN/ChatBoxAI_Educational/frontend/src/components/Common/LanguageSwitcher.tsx)
- Một component chứa Nút/Menu (Dropdown) cho phép chọn "English" hoặc "Tiếng Việt".
- Khi bấm vào sẽ gọi hàm `i18n.changeLanguage()`.

#### [MODIFY] [src/routes/_layout/admin.tsx](file:///d:/DEV_KnowLedge/Done_Project/EduGuide_VN/ChatBoxAI_Educational/frontend/src/routes/_layout/admin.tsx)
- Gắn `LanguageSwitcher` vào giao diện Admin (ví dụ: ở đầu trang hoặc Sidebar).
- Áp dụng `useTranslation` để dịch các tab ở Sidebar (Overview, Users, Analytics, Knowledge Base).

---

### Cập nhật Giao diện Admin (Áp dụng dịch thuật)
Thay thế chữ cứng bằng hàm dịch `t('...')`.

#### [MODIFY] [src/routes/_layout/admin/index.tsx](file:///d:/DEV_KnowLedge/Done_Project/EduGuide_VN/ChatBoxAI_Educational/frontend/src/routes/_layout/admin/index.tsx)
- Dịch phần Tổng quan (Total Users, Page Views, Visits Chart...).

#### [MODIFY] [src/routes/_layout/admin/analytics.tsx](file:///d:/DEV_KnowLedge/Done_Project/EduGuide_VN/ChatBoxAI_Educational/frontend/src/routes/_layout/admin/analytics.tsx)
- Dịch bảng Truy cập (Path, Timestamp, Visitor ID...).

#### [MODIFY] [src/routes/_layout/admin/knowledge.tsx](file:///d:/DEV_KnowLedge/Done_Project/EduGuide_VN/ChatBoxAI_Educational/frontend/src/routes/_layout/admin/knowledge.tsx)
- Dịch các thông số hệ thống Neo4j và văn bản Upload Document.

#### [MODIFY] [src/routes/_layout/admin/users.tsx](file:///d:/DEV_KnowLedge/Done_Project/EduGuide_VN/ChatBoxAI_Educational/frontend/src/routes/_layout/admin/users.tsx)
- Dịch tiêu đề quản lý người dùng và các nút bấm.

---

## Verification Plan

### Manual Verification
- Chạy ứng dụng bằng `bun run dev`.
- Truy cập `/admin`.
- Nhấp vào nút chọn Ngôn ngữ (Anh/Việt) để kiểm tra xem toàn bộ các chữ cái trên màn hình, trên bảng và thanh điều hướng có thay đổi ngay lập tức mà không cần tải lại trang hay không.
- Làm mới trang (F5) xem ngôn ngữ đã chọn có được ghi nhớ lại không.

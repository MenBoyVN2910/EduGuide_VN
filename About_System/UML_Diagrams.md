# 📐 UML Diagrams — Hệ thống EduGuide VN (ChatBoxAI Educational)

> Tài liệu này chứa các biểu đồ UML được trích xuất từ mã nguồn thực tế của dự án.
> Tất cả diagram sử dụng **Mermaid syntax** — có thể render trực tiếp trên GitHub, VS Code, hoặc bất kỳ trình Markdown nào hỗ trợ Mermaid.

---

## 📑 Mục lục

1. [Use Case Diagram](#1--use-case-diagram)
2. [Class Diagram](#2--class-diagram)
3. [Sequence Diagram — Luồng Chat GraphRAG](#3--sequence-diagram--luồng-chat-graphrag)
4. [Component Diagram](#4--component-diagram)
5. [Deployment Diagram](#5--deployment-diagram)
6. [Activity Diagram — Quy trình xử lý Chatbot](#6--activity-diagram)
7. [ER Diagram — Cơ sở dữ liệu](#7--er-diagram)

---

## 1. 🎭 Use Case Diagram

Mô tả các **tác nhân (Actor)** và **chức năng (Use Case)** của hệ thống.

```mermaid
flowchart LR
    %% ── Actors ──
    Guest["🧑 Khách (Guest)"]
    Student["🎓 Sinh viên (User)"]
    Admin["👨‍💼 Quản trị viên (Admin)"]
    GeminiAI["🤖 Gemini AI"]
    Neo4jDB["🗄️ Neo4j Graph DB"]

    %% ── Guest Use Cases ──
    UC_Register["📝 Đăng ký tài khoản"]
    UC_Login["🔐 Đăng nhập"]
    UC_Recovery["🔑 Khôi phục mật khẩu"]

    Guest --> UC_Register
    Guest --> UC_Login
    Guest --> UC_Recovery

    %% ── Student Use Cases ──
    UC_Chat["💬 Hỏi đáp Chatbot"]
    UC_Stream["📡 Chat Streaming (SSE)"]
    UC_Voice["🎤 Nhập liệu giọng nói"]
    UC_Notes["📝 Quản lý Ghi chú"]
    UC_Profile["👤 Cập nhật hồ sơ"]
    UC_Password["🔒 Đổi mật khẩu"]
    UC_Theme["🌓 Chuyển đổi Light/Dark"]
    UC_DeleteMe["🗑️ Xóa tài khoản"]

    Student --> UC_Chat
    Student --> UC_Stream
    Student --> UC_Voice
    Student --> UC_Notes
    Student --> UC_Profile
    Student --> UC_Password
    Student --> UC_Theme
    Student --> UC_DeleteMe

    %% ── Admin Use Cases ──
    UC_UserList["📋 Xem danh sách User"]
    UC_CreateUser["➕ Tạo User mới"]
    UC_EditUser["✏️ Sửa thông tin User"]
    UC_DeleteUser["🗑️ Xóa User"]
    UC_Health["🩺 Kiểm tra sức khỏe hệ thống"]

    Admin --> UC_UserList
    Admin --> UC_CreateUser
    Admin --> UC_EditUser
    Admin --> UC_DeleteUser
    Admin --> UC_Health
    Admin --> UC_Chat

    %% ── System Dependencies ──
    UC_Chat -->|"Phân loại ý định"| GeminiAI
    UC_Chat -->|"Truy vấn Cypher"| Neo4jDB
    UC_Chat -->|"Sinh câu trả lời"| GeminiAI
    UC_Stream -->|"SSE word-by-word"| UC_Chat
```

> [!NOTE]
> **Sinh viên** kế thừa toàn bộ use case của **Khách** (sau khi đăng nhập).
> **Admin** kế thừa toàn bộ use case của **Sinh viên** và có thêm quyền quản trị.

---

## 2. 📦 Class Diagram

Cấu trúc các lớp chính trong Backend (FastAPI + SQLModel + Services).

```mermaid
classDiagram
    direction TB

    %% ═══════════════════════════════════════
    %%  DATABASE MODELS (SQLModel)
    %% ═══════════════════════════════════════
    class UserBase {
        <<abstract>>
        +EmailStr email
        +bool is_active
        +bool is_superuser
        +str full_name
    }

    class User {
        <<table>>
        +UUID id
        +str hashed_password
        +datetime created_at
        +List~Item~ items
    }

    class UserCreate {
        +str password
    }

    class UserRegister {
        +EmailStr email
        +str password
        +str full_name
    }

    class UserUpdate {
        +EmailStr email
        +str password
    }

    class UserUpdateMe {
        +str full_name
        +EmailStr email
    }

    class UpdatePassword {
        +str current_password
        +str new_password
    }

    class UserPublic {
        +UUID id
        +datetime created_at
    }

    class UsersPublic {
        +List~UserPublic~ data
        +int count
    }

    class ItemBase {
        <<abstract>>
        +str title
        +str description
    }

    class Item {
        <<table>>
        +UUID id
        +datetime created_at
        +UUID owner_id
        +User owner
    }

    class ItemCreate {
    }

    class ItemUpdate {
        +str title
    }

    class ItemPublic {
        +UUID id
        +UUID owner_id
        +datetime created_at
    }

    class ItemsPublic {
        +List~ItemPublic~ data
        +int count
    }

    class Token {
        +str access_token
        +str token_type
    }

    class TokenPayload {
        +str sub
    }

    class NewPassword {
        +str token
        +str new_password
    }

    class Message {
        +str message
    }

    UserBase <|-- User
    UserBase <|-- UserCreate
    UserBase <|-- UserUpdate
    UserBase <|-- UserPublic
    User "1" --> "*" Item : items

    ItemBase <|-- Item
    ItemBase <|-- ItemCreate
    ItemBase <|-- ItemUpdate
    ItemBase <|-- ItemPublic

    %% ═══════════════════════════════════════
    %%  SERVICE LAYER (AI Pipeline)
    %% ═══════════════════════════════════════
    class Intent {
        <<enumeration>>
        GREETING
        FAREWELL
        THANKS
        UNIVERSITY_INFO
        COURSE_INFO
        PREREQUISITE
        COREQUISITE
        STUDY_PATH
        CATEGORY_LIST
        MAJOR_INFO
        CREDIT_INFO
        COMPARISON
        COURSE_LIST_ALL
        ELECTIVE_INFO
        GENERAL_ADVICE
        UNRELATED
    }

    class IntentClassifier {
        +classify_intent(message) tuple
        +is_education_related(message) bool
        -_PATTERNS List
        -_UNRELATED_PATTERNS Pattern
    }

    class CypherGenerator {
        +generate_template_cypher(intent, message) tuple
        +generate_llm_cypher(user_question) str
        +generate_fallback_cypher(message) tuple
        +extract_keywords(message) str
        -_extract_course_name(message) str
        -_resolve_category_keyword(message) str
        -_extract_major_keyword(message) str
        -CYPHER_TEMPLATES dict
        -CYPHER_SYSTEM_PROMPT str
    }

    class AnswerGenerator {
        +generate_answer(question, db_data, static_context, messages) str
        -_build_history_context(messages) str
        -SYSTEM_PROMPT str
        -MAX_HISTORY_TURNS int
    }

    class ChatAgent {
        +process_chat_message(messages) str
        +get_cache_stats() dict
        -_try_db_query(intent, message) str
        -_execute_cypher(query, params) list
        -_format_records(records) str
    }

    class QueryCache {
        -OrderedDict _cache
        -int _max_size
        -int _ttl
        -int _hits
        -int _misses
        +get(query, params) list
        +put(query, params, data) void
        +stats() dict
        -_make_key(query, params) str
    }

    class SchemaMetadata {
        +UNIVERSITY_INFO dict
        +ALL_MAJORS dict
        +MAJOR_INFO dict
        +ELECTIVE_GROUPS dict
        +STUDY_PATH list
        +get_university_overview() str
        +get_major_overview() str
        +get_study_path_text() str
        +get_elective_groups_text() str
    }

    ChatAgent --> IntentClassifier : uses
    ChatAgent --> CypherGenerator : uses
    ChatAgent --> AnswerGenerator : uses
    ChatAgent --> QueryCache : uses
    ChatAgent --> SchemaMetadata : uses
    IntentClassifier --> Intent : returns
    CypherGenerator --> Intent : receives

    %% ═══════════════════════════════════════
    %%  INFRASTRUCTURE LAYER
    %% ═══════════════════════════════════════
    class Neo4jConnection {
        -Driver _driver
        +connect() void
        +close() void
        +is_connected() bool
        +health_check() dict
        +session() ContextManager
        +execute_query(query, params) list
        +get_schema_summary() str
    }

    class Settings {
        +str API_V1_STR
        +str SECRET_KEY
        +str PROJECT_NAME
        +str NEO4J_URI
        +str GEMINI_API_KEY
        +str GEMINI_CYPHER_MODEL
        +str GEMINI_ANSWER_MODEL
        +int CACHE_TTL_SECONDS
        +int CACHE_MAX_SIZE
        +all_cors_origins() list
        +SQLALCHEMY_DATABASE_URI() PostgresDsn
    }

    ChatAgent --> Neo4jConnection : queries
    CypherGenerator --> Settings : reads config
    AnswerGenerator --> Settings : reads config

    %% ═══════════════════════════════════════
    %%  API LAYER (FastAPI Routes)
    %% ═══════════════════════════════════════
    class ChatbotRouter {
        +POST /chat : chat()
        +POST /chat/stream : chat_stream()
        +GET /health : health()
    }

    class UsersRouter {
        +GET / : read_users()
        +POST / : create_user()
        +POST /signup : register_user()
        +GET /me : read_user_me()
        +PATCH /me : update_user_me()
        +PATCH /me/password : update_password_me()
        +DELETE /me : delete_user_me()
        +GET /user_id : read_user_by_id()
        +PATCH /user_id : update_user()
        +DELETE /user_id : delete_user()
    }

    class LoginRouter {
        +POST /login/access-token : login()
        +POST /login/test-token : test_token()
        +POST /password-recovery/email : recover()
        +POST /reset-password : reset()
    }

    class ItemsRouter {
        +GET / : read_items()
        +POST / : create_item()
        +GET /item_id : read_item()
        +PUT /item_id : update_item()
        +DELETE /item_id : delete_item()
    }

    ChatbotRouter --> ChatAgent : delegates
    UsersRouter --> User : manages
    ItemsRouter --> Item : manages
    LoginRouter --> Token : generates
```

---

## 3. 🔄 Sequence Diagram — Luồng Chat GraphRAG

Mô tả chi tiết luồng xử lý khi sinh viên gửi một câu hỏi qua Chatbot.

```mermaid
sequenceDiagram
    autonumber
    participant U as 🎓 Sinh viên
    participant FE as 🖥️ Frontend (React)
    participant API as 🚀 FastAPI
    participant Agent as 🧠 ChatAgent
    participant IC as 🏷️ IntentClassifier
    participant CG as ⚙️ CypherGenerator
    participant Cache as 📦 QueryCache
    participant Neo4j as 🗄️ Neo4j
    participant Gemini as 🤖 Gemini AI
    participant AG as 📝 AnswerGenerator

    U->>FE: Gõ câu hỏi "Môn Lập trình web có mấy tín chỉ?"
    FE->>API: POST /api/v1/chatbot/chat/stream<br/>{messages: [...]}

    API->>API: Validate request & auth
    API->>Agent: process_chat_message(messages)

    Note over Agent: Bước 0: Lấy câu hỏi cuối cùng từ user

    Agent->>IC: classify_intent("Môn Lập trình web có mấy tín chỉ?")
    IC->>IC: Chạy Regex patterns<br/>(khớp "tín chỉ" → CREDIT_INFO)
    IC-->>Agent: (Intent.CREDIT_INFO, 0.65)

    Note over Agent: Bước 1: Không phải GREETING/FAREWELL/UNRELATED → tiếp tục

    Agent->>Agent: _try_db_query(CREDIT_INFO, message)

    Note over Agent: Chiến lược 1: Template Cypher
    Agent->>CG: generate_template_cypher(CREDIT_INFO, message)
    CG->>CG: _extract_course_name() → "Lập trình web"
    CG-->>Agent: (CYPHER_TEMPLATE, {keyword: "Lập trình web"})

    Agent->>Cache: get(query, params)
    Cache-->>Agent: null (CACHE MISS)

    Agent->>Neo4j: execute_query(cypher, params)
    Neo4j-->>Agent: [{id: "CMP175", name: "Lập trình web", credits: 3, ...}]

    Agent->>Cache: put(query, params, records)
    Agent->>Agent: _format_records(records) → text

    Note over Agent: Bước 2: Sinh câu trả lời tự nhiên
    Agent->>AG: generate_answer(question, db_data, context, messages)
    AG->>AG: _build_history_context(messages)
    AG->>Gemini: generate_content(prompt)
    Gemini-->>AG: "📚 Môn **Lập trình web** (CMP175) có **3 tín chỉ**..."
    AG-->>Agent: reply_text

    Agent-->>API: reply_text

    Note over API: SSE Streaming: Chia thành từng từ
    loop Mỗi từ trong reply
        API-->>FE: data: {"type":"chunk","content":"📚 "}
        FE->>FE: Append text (hiệu ứng gõ chữ)
    end
    API-->>FE: data: {"type":"done"}

    FE->>U: Hiển thị câu trả lời hoàn chỉnh
```

---

## 4. 🧩 Component Diagram

Kiến trúc tổng thể của hệ thống chia theo các thành phần (Component).

```mermaid
flowchart TB
    subgraph Client["🖥️ Client Layer"]
        Browser["🌐 Web Browser"]
        VoiceAPI["🎤 Web Speech API"]
    end

    subgraph Frontend["📱 Frontend (React + Vite + TailwindCSS)"]
        direction TB
        Router["🛤️ TanStack Router"]
        ChatUI["💬 Chat Component"]
        NotesUI["📝 Notes Component"]
        AdminUI["👨‍💼 Admin Panel"]
        SettingsUI["⚙️ User Settings"]
        SidebarUI["📌 Sidebar Navigation"]
        ThemeProvider["🌓 Theme Provider"]
        AuthHook["🔐 Auth Hooks"]
        APIClient["📡 Generated API Client"]
    end

    subgraph Backend["🚀 Backend (FastAPI)"]
        direction TB
        subgraph APIRoutes["API Routes (/api/v1)"]
            LoginRoute["/login/*"]
            UserRoute["/users/*"]
            ChatRoute["/chatbot/*"]
            ItemRoute["/items/*"]
        end

        subgraph Services["🧠 AI Services"]
            ChatAgentSvc["ChatAgent Orchestrator"]
            IntentSvc["Intent Classifier"]
            CypherSvc["Cypher Generator"]
            AnswerSvc["Answer Generator"]
            SchemaSvc["Schema Metadata"]
            CacheSvc["Query Cache (LRU)"]
        end

        subgraph Core["⚙️ Core"]
            ConfigMod["Settings Config"]
            SecurityMod["Security (JWT + Argon2)"]
            Neo4jMod["Neo4j Connection"]
            DBMod["PostgreSQL Connection"]
        end

        CRUD["CRUD Operations"]
    end

    subgraph ExternalServices["☁️ External Services"]
        GeminiAPI["🤖 Google Gemini API"]
        SMTPServer["📧 SMTP Server"]
        SentrySDK["📊 Sentry Monitoring"]
    end

    subgraph Databases["🗄️ Databases"]
        PostgreSQL[("🐘 PostgreSQL 18<br/>Users, Items")]
        Neo4jGraphDB[("🔵 Neo4j 5<br/>Courses, Majors,<br/>Prerequisites")]
    end

    Browser --> Frontend
    VoiceAPI --> ChatUI
    Frontend --> APIClient
    APIClient --> APIRoutes

    ChatRoute --> ChatAgentSvc
    ChatAgentSvc --> IntentSvc
    ChatAgentSvc --> CypherSvc
    ChatAgentSvc --> AnswerSvc
    ChatAgentSvc --> SchemaSvc
    ChatAgentSvc --> CacheSvc

    CypherSvc --> GeminiAPI
    AnswerSvc --> GeminiAPI
    ChatAgentSvc --> Neo4jMod
    Neo4jMod --> Neo4jGraphDB

    LoginRoute --> SecurityMod
    UserRoute --> CRUD
    ItemRoute --> CRUD
    CRUD --> DBMod
    DBMod --> PostgreSQL

    SecurityMod --> ConfigMod
    LoginRoute --> SMTPServer
    Backend --> SentrySDK
```

---

## 5. 🐳 Deployment Diagram

Mô hình triển khai thực tế với Docker Compose.

```mermaid
flowchart TB
    subgraph Internet["🌐 Internet"]
        UserBrowser["🧑‍💻 Trình duyệt User"]
    end

    subgraph DockerHost["🐳 Docker Host"]
        subgraph TraefikNetwork["traefik-public network"]
            Proxy["🔀 Traefik Proxy<br/>Reverse Proxy + SSL"]
        end

        subgraph AppServices["Application Services"]
            FE["📱 Frontend Container<br/>Nginx + React Build<br/>Port: 80"]
            BE["🚀 Backend Container<br/>FastAPI + Uvicorn<br/>Port: 8000"]
            Prestart["🔧 Prestart Container<br/>DB Migration (Alembic)<br/>One-shot"]
        end

        subgraph DataServices["Data Services"]
            PG[("🐘 PostgreSQL 18<br/>Port: 5432<br/>Volume: app-db-data")]
            Neo4j[("🔵 Neo4j 5<br/>Port: 7474 (HTTP)<br/>Port: 7687 (Bolt)<br/>Volume: neo4j-data")]
        end

        subgraph DevTools["Dev Tools"]
            Adminer["🔧 Adminer<br/>DB Admin UI<br/>Port: 8080"]
            MailCatcher["📧 MailCatcher<br/>SMTP Testing"]
            Playwright["🧪 Playwright<br/>E2E Testing"]
        end
    end

    subgraph CloudServices["☁️ Cloud APIs"]
        Gemini["🤖 Google Gemini<br/>gemini-2.5-flash"]
        Sentry["📊 Sentry DSN"]
    end

    UserBrowser -->|"HTTPS"| Proxy
    Proxy -->|"dashboard.*"| FE
    Proxy -->|"api.*"| BE
    Proxy -->|"adminer.*"| Adminer

    FE -->|"API calls"| BE
    Prestart -->|"Alembic migrate"| PG
    BE -->|"SQLAlchemy"| PG
    BE -->|"Bolt protocol"| Neo4j
    BE -->|"REST API"| Gemini
    BE -->|"DSN"| Sentry
    Adminer --> PG

    style Prestart stroke-dasharray: 5 5
```

> [!TIP]
> Container **Prestart** chỉ chạy một lần khi khởi động để thực hiện database migration (Alembic), sau đó tự động dừng.

---

## 6. 🔁 Activity Diagram

Quy trình xử lý khi nhận tin nhắn từ người dùng (Pipeline xử lý chính của ChatAgent).

```mermaid
flowchart TD
    Start([🟢 Bắt đầu: Nhận tin nhắn])
    ExtractMsg["Trích xuất câu hỏi cuối cùng<br/>từ danh sách messages"]
    CheckEmpty{Câu hỏi<br/>rỗng?}
    ReturnGreeting["Trả về lời chào mặc định"]

    ClassifyIntent["🏷️ Phân loại ý định<br/>(Regex + Priority)"]
    CheckIntent{Loại<br/>ý định?}

    ReturnStatic["Trả về phản hồi tĩnh<br/>(GREETING/FAREWELL/THANKS/UNRELATED)"]

    CheckStaticKnowledge{Có kiến thức<br/>tĩnh?}
    LoadStatic["📚 Tải dữ liệu tĩnh<br/>(University/Major/StudyPath/Elective)"]

    TryDB["🔍 _try_db_query()"]

    subgraph Strategy["Chiến lược truy vấn DB"]
        S1["1️⃣ Template Cypher<br/>(Nhanh, chính xác)"]
        S1Check{Có kết quả?}
        S2["2️⃣ LLM Cypher<br/>(Gemini sinh Cypher)"]
        S2Check{Có kết quả?}
        S3["3️⃣ Fallback Broad Search<br/>(Tìm kiếm từ khóa)"]
        S3Check{Có kết quả?}
        NoData["Trả về chuỗi rỗng"]
    end

    CheckCache{Cache<br/>hit?}
    ReturnCache["📦 Trả kết quả từ Cache"]
    ExecuteNeo4j["🗄️ Thực thi truy vấn Neo4j"]
    SaveCache["💾 Lưu vào Cache"]

    CheckDBData{Có dữ liệu<br/>từ DB?}
    LowConfidence{Độ tin cậy<br/>< 0.5?}
    ReturnNoData["Trả về NO_DATA_RESPONSE"]
    
    GenerateAnswer["🤖 generate_answer()<br/>Gọi Gemini AI tổng hợp"]
    
    ReturnAnswer["📤 Trả câu trả lời Markdown"]
    End([🔴 Kết thúc])

    Start --> ExtractMsg --> CheckEmpty
    CheckEmpty -->|Có| ReturnGreeting --> End
    CheckEmpty -->|Không| ClassifyIntent --> CheckIntent

    CheckIntent -->|"GREETING/<br/>FAREWELL/<br/>THANKS/<br/>UNRELATED"| ReturnStatic --> End

    CheckIntent -->|"UNIVERSITY_INFO/<br/>MAJOR_INFO/<br/>STUDY_PATH/<br/>ELECTIVE_INFO"| CheckStaticKnowledge
    CheckStaticKnowledge -->|Có| LoadStatic --> TryDB

    CheckIntent -->|"COURSE_INFO/<br/>CREDIT_INFO/<br/>PREREQUISITE/<br/>etc."| TryDB

    TryDB --> S1 --> S1Check
    S1Check -->|Có| CheckCache
    S1Check -->|Không| S2 --> S2Check
    S2Check -->|Có| CheckCache
    S2Check -->|Không| S3 --> S3Check
    S3Check -->|Có| CheckCache
    S3Check -->|Không| NoData

    CheckCache -->|Hit| ReturnCache --> CheckDBData
    CheckCache -->|Miss| ExecuteNeo4j --> SaveCache --> CheckDBData

    NoData --> CheckDBData
    CheckDBData -->|Có| GenerateAnswer
    CheckDBData -->|Không| LowConfidence
    LowConfidence -->|Có| GenerateAnswer
    LowConfidence -->|Không| ReturnNoData --> End

    GenerateAnswer --> ReturnAnswer --> End
```

---

## 7. 🗃️ ER Diagram — Cơ sở dữ liệu

### 7.1 PostgreSQL (Relational — Quản lý người dùng)

```mermaid
erDiagram
    USER {
        UUID id PK "Primary Key (uuid4)"
        VARCHAR(255) email UK "Unique, Indexed"
        VARCHAR hashed_password "Argon2 hash"
        BOOLEAN is_active "Default: true"
        BOOLEAN is_superuser "Default: false"
        VARCHAR(255) full_name "Nullable"
        TIMESTAMP created_at "UTC timezone"
    }

    ITEM {
        UUID id PK "Primary Key (uuid4)"
        VARCHAR(255) title "Min: 1 char"
        VARCHAR(255) description "Nullable"
        UUID owner_id FK "References USER.id"
        TIMESTAMP created_at "UTC timezone"
    }

    USER ||--o{ ITEM : "owns (CASCADE DELETE)"
```

### 7.2 Neo4j (Graph — Chương trình đào tạo)

```mermaid
erDiagram
    UNIVERSITY {
        string id PK "e.g. HUTECH"
        string name "Tên trường"
        string abbreviation "Viết tắt"
        string address "Địa chỉ"
        string website "Website"
    }

    MAJOR {
        string id PK "Mã ngành (7480201)"
        string name "Tên ngành"
        string university "Tên trường"
        int total_credits "Tổng TC tích lũy"
        int non_accum_credits "TC không tích lũy"
    }

    COURSE {
        string id PK "Mã môn (CMP175)"
        string name "Tên môn học"
        int credits "Số tín chỉ"
        string category "Nhóm môn học"
    }

    UNIVERSITY ||--o{ MAJOR : "OFFERS"
    COURSE }o--|| MAJOR : "BELONGS_TO"
    COURSE ||--o{ COURSE : "PREREQUISITE_FOR"
    COURSE ||--o{ COURSE : "COREQUISITE_WITH"
```

> [!IMPORTANT]
> **Neo4j Relationships:**
> - `OFFERS`: Trường đào tạo ngành (University → Major)
> - `BELONGS_TO`: Môn thuộc ngành (Course → Major)
> - `PREREQUISITE_FOR`: Môn tiên quyết — phải hoàn thành trước (Course → Course)
> - `COREQUISITE_WITH`: Môn song hành — Thực hành đi kèm Lý thuyết (Course → Course)

---

## 📌 Tóm tắt kiến trúc hệ thống

| Thành phần | Công nghệ | Vai trò |
|:---|:---|:---|
| **Frontend** | React + Vite + TailwindCSS + TanStack Router | Giao diện người dùng SPA |
| **Backend** | FastAPI + SQLModel + Pydantic | REST API + AI Pipeline |
| **Auth** | JWT (OAuth2) + Argon2 Password Hashing | Xác thực & Phân quyền |
| **Relational DB** | PostgreSQL 18 | Lưu trữ User, Item |
| **Graph DB** | Neo4j 5 | Knowledge Graph — Môn học, Ngành, Quan hệ |
| **AI Engine** | Google Gemini 2.5 Flash | Phân loại ý định, Sinh Cypher, Tạo câu trả lời |
| **Caching** | LRU Cache (in-memory) | Cache kết quả Cypher (TTL 10 phút) |
| **Reverse Proxy** | Traefik | SSL termination, Routing |
| **Containerization** | Docker Compose | Orchestration toàn bộ stack |

---

*Tài liệu được tạo tự động từ phân tích mã nguồn dự án EduGuide VN — Tháng 05/2026.*

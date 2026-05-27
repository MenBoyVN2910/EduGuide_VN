import {
  createContext,
  useCallback,
  useContext,
  useEffect,
  useState,
  type ReactNode,
} from "react"
import type { ChatMessageProps } from "./ChatMessage"

// ─── Types ────────────────────────────────────────────────────────────────────

export interface Conversation {
  id: string
  title: string
  messages: ChatMessageProps[]
  createdAt: number
}

interface ChatHistoryContextValue {
  conversations: Conversation[]
  activeId: string | null
  activeConversation: Conversation | null
  createConversation: () => void
  selectConversation: (id: string) => void
  deleteConversation: (id: string) => void
  updateConversation: (id: string, messages: ChatMessageProps[]) => void
}

// ─── Context ──────────────────────────────────────────────────────────────────

const ChatHistoryContext = createContext<ChatHistoryContextValue | null>(null)

/** Tạo storage key riêng cho từng user — cô lập dữ liệu giữa các tài khoản */
function getStorageKey(userId: string) {
  return `chatbox_history_${userId}`
}

function generateId() {
  return `conv_${Date.now()}_${Math.random().toString(36).slice(2, 7)}`
}

function makeNew(): Conversation {
  return {
    id: generateId(),
    title: "Cuộc trò chuyện mới",
    messages: [],
    createdAt: Date.now(),
  }
}

function loadFromStorage(userId: string): Conversation[] {
  try {
    const raw = localStorage.getItem(getStorageKey(userId))
    if (!raw) return []
    return JSON.parse(raw) as Conversation[]
  } catch {
    return []
  }
}

function saveToStorage(userId: string, conversations: Conversation[]) {
  localStorage.setItem(getStorageKey(userId), JSON.stringify(conversations))
}

// ─── Provider ─────────────────────────────────────────────────────────────────

interface ChatHistoryProviderProps {
  children: ReactNode
  userId: string
}

export function ChatHistoryProvider({ children, userId }: ChatHistoryProviderProps) {
  const [conversations, setConversations] = useState<Conversation[]>(() => {
    const loaded = loadFromStorage(userId)
    return loaded.length > 0 ? loaded : [makeNew()]
  })

  const [activeId, setActiveId] = useState<string | null>(() => {
    const loaded = loadFromStorage(userId)
    return loaded.length > 0 ? loaded[0].id : null
  })

  // Khi userId thay đổi (đăng nhập tài khoản khác), load lại dữ liệu từ localStorage key mới
  useEffect(() => {
    const loaded = loadFromStorage(userId)
    if (loaded.length > 0) {
      setConversations(loaded)
      setActiveId(loaded[0].id)
    } else {
      const fresh = makeNew()
      setConversations([fresh])
      setActiveId(fresh.id)
    }
  }, [userId])

  // Persist whenever conversations change
  useEffect(() => {
    saveToStorage(userId, conversations)
  }, [userId, conversations])

  // If activeId is not set, default to first
  useEffect(() => {
    if (!activeId && conversations.length > 0) {
      setActiveId(conversations[0].id)
    }
  }, [activeId, conversations])

  const activeConversation =
    conversations.find((c) => c.id === activeId) ?? null

  const createConversation = useCallback(() => {
    const newConv = makeNew()
    setConversations((prev) => [newConv, ...prev])
    setActiveId(newConv.id)
  }, [])

  const selectConversation = useCallback((id: string) => {
    setActiveId(id)
  }, [])

  const deleteConversation = useCallback(
    (id: string) => {
      setConversations((prev) => {
        const filtered = prev.filter((c) => c.id !== id)
        // If we deleted the active one, switch to the next available
        if (activeId === id) {
          if (filtered.length > 0) {
            setActiveId(filtered[0].id)
          } else {
            const fresh = makeNew()
            setActiveId(fresh.id)
            return [fresh]
          }
        }
        return filtered.length > 0 ? filtered : [makeNew()]
      })
    },
    [activeId],
  )

  const updateConversation = useCallback(
    (id: string, messages: ChatMessageProps[]) => {
      setConversations((prev) =>
        prev.map((c) => {
          if (c.id !== id) return c
          // Auto-title from first user message
          const firstUser = messages.find((m) => m.role === "user")
          const title =
            firstUser
              ? firstUser.content.slice(0, 45) + (firstUser.content.length > 45 ? "…" : "")
              : c.title
          return { ...c, messages, title }
        }),
      )
    },
    [],
  )

  return (
    <ChatHistoryContext.Provider
      value={{
        conversations,
        activeId,
        activeConversation,
        createConversation,
        selectConversation,
        deleteConversation,
        updateConversation,
      }}
    >
      {children}
    </ChatHistoryContext.Provider>
  )
}

// ─── Hook ─────────────────────────────────────────────────────────────────────

export function useChatHistory() {
  const ctx = useContext(ChatHistoryContext)
  if (!ctx) {
    throw new Error("useChatHistory must be used inside <ChatHistoryProvider>")
  }
  return ctx
}

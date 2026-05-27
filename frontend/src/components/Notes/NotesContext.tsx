import {
  createContext,
  useCallback,
  useContext,
  useEffect,
  useRef,
  useState,
  type ReactNode,
} from "react"

// ─── Types ────────────────────────────────────────────────────────────────────

export interface Note {
  id: number       // Số thứ tự tăng dần
  title: string
  content: string
  createdAt: number
  updatedAt: number
}

interface NotesContextValue {
  notes: Note[]
  addNote: (title: string, content: string) => void
  updateNote: (id: number, title: string, content: string) => void
  deleteNote: (id: number) => void
}

// ─── Context ──────────────────────────────────────────────────────────────────

const NotesContext = createContext<NotesContextValue | null>(null)

/** Tạo storage key riêng cho từng user — cô lập dữ liệu giữa các tài khoản */
function getNotesKey(userId: string) {
  return `chatbox_notes_${userId}`
}

function getCounterKey(userId: string) {
  return `chatbox_notes_counter_${userId}`
}

function loadNotes(userId: string): Note[] {
  try {
    const raw = localStorage.getItem(getNotesKey(userId))
    return raw ? (JSON.parse(raw) as Note[]) : []
  } catch {
    return []
  }
}

function loadCounter(userId: string): number {
  return Number(localStorage.getItem(getCounterKey(userId)) ?? "0")
}

// ─── Provider ─────────────────────────────────────────────────────────────────

interface NotesProviderProps {
  children: ReactNode
  userId: string
}

export function NotesProvider({ children, userId }: NotesProviderProps) {
  const [notes, setNotes] = useState<Note[]>(() => loadNotes(userId))

  // Dùng useRef để counter không trigger re-render và tránh nested setState
  const counterRef = useRef<number>(loadCounter(userId))

  // Khi userId thay đổi (đăng nhập tài khoản khác), load lại dữ liệu từ localStorage key mới
  useEffect(() => {
    setNotes(loadNotes(userId))
    counterRef.current = loadCounter(userId)
  }, [userId])

  // Persist notes
  useEffect(() => {
    localStorage.setItem(getNotesKey(userId), JSON.stringify(notes))
  }, [userId, notes])

  const addNote = useCallback((title: string, content: string) => {
    // Tăng counter trực tiếp qua ref — không gây re-render, không bị gọi 2 lần
    counterRef.current += 1
    const nextId = counterRef.current
    localStorage.setItem(getCounterKey(userId), String(nextId))

    const now = Date.now()
    setNotes((prev) => [
      ...prev,
      {
        id: nextId,
        title: title.trim() || "Ghi chú mới",
        content,
        createdAt: now,
        updatedAt: now,
      },
    ])
  }, [userId])

  const updateNote = useCallback((id: number, title: string, content: string) => {
    setNotes((prev) =>
      prev.map((n) =>
        n.id === id
          ? { ...n, title: title.trim() || "Ghi chú mới", content, updatedAt: Date.now() }
          : n,
      ),
    )
  }, [])

  const deleteNote = useCallback((id: number) => {
    setNotes((prev) => {
      const filtered = prev.filter((n) => n.id !== id)
      // Reset counter về 0 khi xóa hết tất cả ghi chú
      if (filtered.length === 0) {
        counterRef.current = 0
        localStorage.setItem(getCounterKey(userId), "0")
      }
      return filtered
    })
  }, [userId])

  return (
    <NotesContext.Provider value={{ notes, addNote, updateNote, deleteNote }}>
      {children}
    </NotesContext.Provider>
  )
}

// ─── Hook ─────────────────────────────────────────────────────────────────────

export function useNotes() {
  const ctx = useContext(NotesContext)
  if (!ctx) throw new Error("useNotes must be used inside <NotesProvider>")
  return ctx
}

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

const STORAGE_KEY = "chatbox_notes"
const COUNTER_KEY = "chatbox_notes_counter"

function loadNotes(): Note[] {
  try {
    const raw = localStorage.getItem(STORAGE_KEY)
    return raw ? (JSON.parse(raw) as Note[]) : []
  } catch {
    return []
  }
}

function loadCounter(): number {
  return Number(localStorage.getItem(COUNTER_KEY) ?? "0")
}

// ─── Provider ─────────────────────────────────────────────────────────────────

export function NotesProvider({ children }: { children: ReactNode }) {
  const [notes, setNotes] = useState<Note[]>(loadNotes)

  // Dùng useRef để counter không trigger re-render và tránh nested setState
  const counterRef = useRef<number>(loadCounter())

  // Persist notes
  useEffect(() => {
    localStorage.setItem(STORAGE_KEY, JSON.stringify(notes))
  }, [notes])

  const addNote = useCallback((title: string, content: string) => {
    // Tăng counter trực tiếp qua ref — không gây re-render, không bị gọi 2 lần
    counterRef.current += 1
    const nextId = counterRef.current
    localStorage.setItem(COUNTER_KEY, String(nextId))

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
  }, [])

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
        localStorage.setItem(COUNTER_KEY, "0")
      }
      return filtered
    })
  }, [])

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

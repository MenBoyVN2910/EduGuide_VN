import { createFileRoute } from "@tanstack/react-router"
import { AnimatePresence, motion } from "framer-motion"
import { Plus, Search, StickyNote, X } from "lucide-react"
import { useEffect, useRef, useState } from "react"

import { NoteCard } from "@/components/Notes/NoteCard"
import { NotesProvider, useNotes } from "@/components/Notes/NotesContext"
import { Button } from "@/components/ui/button"

export const Route = createFileRoute("/_layout/items")({
  component: NotesPage,
  head: () => ({
    meta: [{ title: "Ghi Chú - EduGuide VN" }],
  }),
})

// ─── Dialog thêm ghi chú mới ─────────────────────────────────────────────────

function AddNoteDialog({ onClose }: { onClose: () => void }) {
  const { addNote } = useNotes()
  const [title, setTitle] = useState("")
  const [content, setContent] = useState("")
  const titleRef = useRef<HTMLInputElement>(null)

  useEffect(() => {
    titleRef.current?.focus()
  }, [])

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault()
    addNote(title, content)
    onClose()
  }

  return (
    <motion.div
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      exit={{ opacity: 0 }}
      className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/60 backdrop-blur-[2px]"
      onClick={onClose}
    >
      <motion.div
        initial={{ opacity: 0, scale: 0.95, y: 15 }}
        animate={{ opacity: 1, scale: 1, y: 0 }}
        exit={{ opacity: 0, scale: 0.95, y: 15 }}
        transition={{ type: "spring", stiffness: 300, damping: 30 }}
        onClick={(e) => e.stopPropagation()}
        className="w-full max-w-lg bg-card rounded-[24px] border border-border shadow-2xl overflow-hidden"
      >
        <form onSubmit={handleSubmit}>
          <div className="px-7 py-6 border-b border-border/50 flex justify-between items-center">
            <div>
              <h2 className="text-xl font-bold tracking-tight">Thêm ghi chú</h2>
              <p className="text-xs text-muted-foreground mt-0.5">Lưu ý lại kiến thức quan trọng của bạn.</p>
            </div>
            <button 
              type="button" 
              onClick={onClose} 
              className="p-2 rounded-full hover:bg-muted transition-colors text-muted-foreground"
            >
              <X size={18} />
            </button>
          </div>
          <div className="px-7 py-6 flex flex-col gap-5">
            <div className="flex flex-col gap-2">
              <label htmlFor="note-title" className="text-[13px] font-semibold text-foreground/80 ml-1">Tiêu đề</label>
              <input
                ref={titleRef}
                id="note-title"
                type="text"
                value={title}
                onChange={(e) => setTitle(e.target.value)}
                placeholder="Ví dụ: Công thức Toán giải tích..."
                className="w-full rounded-2xl border border-border bg-muted/30 px-4 py-3 text-sm transition-all focus:border-primary/50 focus:ring-[3px] focus:ring-primary/10 outline-none"
              />
            </div>
            <div className="flex flex-col gap-2">
              <label htmlFor="note-content" className="text-[13px] font-semibold text-foreground/80 ml-1">Nội dung</label>
              <textarea
                id="note-content"
                value={content}
                onChange={(e) => setContent(e.target.value)}
                placeholder="Nhập nội dung chi tiết tại đây..."
                rows={5}
                className="w-full resize-none rounded-2xl border border-border bg-muted/30 px-4 py-3 text-sm leading-relaxed transition-all focus:border-primary/50 focus:ring-[3px] focus:ring-primary/10 outline-none font-[inherit]"
              />
            </div>
          </div>
          <div className="flex justify-end gap-3 px-7 py-5 border-t border-border/50 bg-muted/10">
            <Button type="button" variant="ghost" className="rounded-xl px-5" onClick={onClose}>Hủy</Button>
            <Button type="submit" className="rounded-xl px-6 gap-2 font-medium shadow-sm bg-primary hover:bg-primary/90">
              <Plus size={16} /> Lưu ghi chú
            </Button>
          </div>
        </form>
      </motion.div>
    </motion.div>
  )
}

// ─── Notes List ───────────────────────────────────────────────────────────────

function NotesList() {
  const { notes, deleteNote, updateNote } = useNotes()
  const [showAdd, setShowAdd] = useState(false)
  const [search, setSearch] = useState("")

  const filteredNotes = notes.filter(n => 
    n.title.toLowerCase().includes(search.toLowerCase()) || 
    n.content.toLowerCase().includes(search.toLowerCase())
  ).sort((a, b) => b.updatedAt - a.updatedAt)

  return (
    <div className="flex flex-col h-full bg-background text-foreground animate-in fade-in duration-500">
      {/* Page Header Concept: Clean & Modern */}
      <div className="p-6 md:p-8 flex flex-col gap-6 max-w-[1400px] mx-auto w-full">
        <div className="flex flex-col md:flex-row md:items-center justify-between gap-4">
          <div>
            <h1 className="text-3xl font-extrabold tracking-tight flex items-center gap-3">
              <div className="bg-primary/10 p-2 rounded-2xl">
                 <StickyNote className="text-primary h-7 w-7" />
              </div>
              Ghi Chú
            </h1>
            <p className="text-muted-foreground text-sm mt-1 ml-13">
              Quản lý tài liệu học tập của bạn tập trung.
            </p>
          </div>
          
          <div className="flex items-center gap-3">
            <div className="relative group flex-1 md:w-[300px]">
              <Search className="absolute left-3.5 top-1/2 -translate-y-1/2 h-4 w-4 text-muted-foreground group-focus-within:text-primary transition-colors" />
              <input 
                type="text" 
                placeholder="Tìm nội dung ghi chú..."
                value={search}
                onChange={(e) => setSearch(e.target.value)}
                className="w-full bg-muted/40 border border-border rounded-2xl py-2.5 pl-10 pr-4 text-sm focus:bg-muted/10 transition-all outline-none focus:ring-2 focus:ring-primary/10 focus:border-primary/30"
              />
            </div>
            <Button onClick={() => setShowAdd(true)} className="rounded-2xl h-11 px-6 shadow-lg shadow-primary/20 hover:scale-[1.02] active:scale-[0.98] transition-all gap-2 font-bold">
              <Plus size={18} strokeWidth={3} />
              Tạo mới
            </Button>
          </div>
        </div>

        <div className="h-px w-full bg-linear-to-r from-transparent via-border to-transparent opacity-50" />

        {/* Dynamic Display */}
        <AnimatePresence mode="wait">
          {notes.length === 0 ? (
            <motion.div
              key="empty"
              initial={{ opacity: 0, y: 10 }}
              animate={{ opacity: 1, y: 0 }}
              exit={{ opacity: 0, scale: 0.95 }}
              className="flex flex-col items-center justify-center py-24 text-center"
            >
              <div className="relative mb-6">
                <div className="absolute inset-0 bg-primary/20 blur-3xl rounded-full" />
                <div className="relative flex items-center justify-center h-24 w-24 rounded-[32px] bg-muted shadow-inner ring-1 ring-border">
                  <StickyNote className="h-12 w-12 text-primary/40" />
                </div>
              </div>
              <h3 className="text-2xl font-bold mb-2">Chưa có bản ghi nào</h3>
              <p className="max-w-xs text-muted-foreground mb-8 leading-relaxed text-sm">
                Bắt đầu ghi lại những kiến thức hay bạn vừa học được từ AI bằng cách nhấn nút phía trên.
              </p>
              <Button onClick={() => setShowAdd(true)} variant="outline" className="rounded-xl px-8 h-10 border-primary/20 hover:bg-primary/5 text-primary font-semibold">
                Bắt đầu ghi chú
              </Button>
            </motion.div>
          ) : filteredNotes.length === 0 ? (
            <motion.div
              key="no-results"
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              className="py-20 text-center"
            >
               <p className="text-muted-foreground">Không tìm thấy ghi chú nào khớp với "<span className="text-foreground font-medium">{search}</span>"</p>
              <Button type="button" onClick={() => setSearch("")} className="text-primary text-sm font-medium mt-2 hover:underline">Xóa ô tìm kiếm</Button>
            </motion.div>
          ) : (
            <motion.div
              key="results"
              layout
              className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-5"
            >
              <AnimatePresence mode="popLayout">
                {filteredNotes.map((note) => (
                  <NoteCard
                    key={note.id}
                    note={note}
                    onDelete={deleteNote}
                    onUpdate={updateNote}
                  />
                ))}
              </AnimatePresence>
            </motion.div>
          )}
        </AnimatePresence>
      </div>

      {/* Modal Overlay Thêm mới */}
      <AnimatePresence>
        {showAdd && <AddNoteDialog onClose={() => setShowAdd(false)} />}
      </AnimatePresence>
    </div>
  )
}

// ─── Page Wrapper ─────────────────────────────────────────────────────────────

function NotesPage() {
  return (
    <div className="h-full w-full overflow-y-auto">
      <NotesProvider>
        <NotesList />
      </NotesProvider>
    </div>
  )
}

export default NotesPage

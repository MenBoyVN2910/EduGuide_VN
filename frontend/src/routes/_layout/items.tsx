import { createFileRoute } from "@tanstack/react-router"
import { AnimatePresence, motion } from "framer-motion"
import { Plus, StickyNote } from "lucide-react"
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
      className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/50 backdrop-blur-sm"
      onClick={onClose}
    >
      <motion.div
        initial={{ opacity: 0, scale: 0.94, y: 20 }}
        animate={{ opacity: 1, scale: 1, y: 0 }}
        exit={{ opacity: 0, scale: 0.93, y: 20 }}
        transition={{ type: "spring", stiffness: 300, damping: 28 }}
        onClick={(e) => e.stopPropagation()}
        className="w-full max-w-lg bg-card rounded-2xl border shadow-2xl overflow-hidden"
      >
        <form onSubmit={handleSubmit}>
          <div className="px-6 py-5 border-b border-border/50 bg-muted/20">
            <h2 className="text-lg font-bold">Thêm ghi chú mới</h2>
            <p className="text-sm text-muted-foreground">Điền tiêu đề và nội dung</p>
          </div>
          <div className="px-6 py-5 flex flex-col gap-4">
            <div className="flex flex-col gap-1.5">
              <label htmlFor="note-title" className="text-sm font-medium">Tiêu đề</label>
              <input
                ref={titleRef}
                id="note-title"
                type="text"
                value={title}
                onChange={(e) => setTitle(e.target.value)}
                placeholder="Nhập tiêu đề..."
                className="w-full rounded-xl border border-border/60 bg-background px-4 py-2.5 text-sm outline-none focus:border-primary/60 focus:ring-2 focus:ring-primary/20 transition-all"
              />
            </div>
            <div className="flex flex-col gap-1.5">
              <label htmlFor="note-content" className="text-sm font-medium">Nội dung</label>
              <textarea
                id="note-content"
                value={content}
                onChange={(e) => setContent(e.target.value)}
                placeholder="Nhập nội dung ghi chú..."
                rows={4}
                className="w-full resize-none rounded-xl border border-border/60 bg-background px-4 py-2.5 text-sm leading-relaxed outline-none focus:border-primary/60 focus:ring-2 focus:ring-primary/20 transition-all font-[inherit]"
              />
            </div>
          </div>
          <div className="flex justify-end gap-2 px-6 py-4 border-t border-border/50 bg-muted/10">
            <Button type="button" variant="ghost" size="sm" onClick={onClose}>Hủy</Button>
            <Button type="submit" size="sm" className="gap-1.5">
              <Plus size={13} /> Thêm ghi chú
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

  return (
    <>
      {/* Page Header */}
      <div className="flex items-center justify-between mb-6">
        <div>
          <h1 className="text-2xl font-bold tracking-tight flex items-center gap-2">
            <StickyNote className="text-primary" size={24} />
            Ghi Chú
          </h1>
          <p className="text-muted-foreground text-sm mt-0.5">
            {notes.length > 0 ? `${notes.length} ghi chú` : "Chưa có ghi chú nào"}
          </p>
        </div>
        <Button onClick={() => setShowAdd(true)} className="gap-2">
          <Plus size={15} />
          Thêm ghi chú
        </Button>
      </div>

      {/* Empty state */}
      {notes.length === 0 && (
        <motion.div
          initial={{ opacity: 0, y: 10 }}
          animate={{ opacity: 1, y: 0 }}
          className="flex flex-col items-center justify-center py-20 text-center"
        >
          <div className="rounded-full bg-primary/10 p-5 mb-4">
            <StickyNote className="h-10 w-10 text-primary/60" />
          </div>
          <h3 className="text-lg font-semibold mb-1">Chưa có ghi chú nào</h3>
          <p className="text-muted-foreground text-sm mb-5">Bấm nút bên trên để thêm ghi chú đầu tiên</p>
          <Button variant="outline" onClick={() => setShowAdd(true)} className="gap-2">
            <Plus size={14} /> Tạo ghi chú mới
          </Button>
        </motion.div>
      )}

      {/* Notes grid */}
      {notes.length > 0 && (
        <motion.div
          layout
          className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4"
        >
          <AnimatePresence mode="popLayout">
            {notes.map((note) => (
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

      {/* Dialog thêm mới */}
      <AnimatePresence>
        {showAdd && <AddNoteDialog onClose={() => setShowAdd(false)} />}
      </AnimatePresence>
    </>
  )
}

// ─── Page ─────────────────────────────────────────────────────────────────────

function NotesPage() {
  return (
    <NotesProvider>
      <NotesList />
    </NotesProvider>
  )
}

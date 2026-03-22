import { useEffect, useRef, useState } from "react"
import { X, Save } from "lucide-react"
import { motion, AnimatePresence } from "framer-motion"
import type { Note } from "./NotesContext"
import { Button } from "@/components/ui/button"

interface NoteViewModalProps {
  note: Note
  open: boolean
  onClose: () => void
  onSave: (title: string, content: string) => void
}

export function NoteViewModal({ note, open, onClose, onSave }: NoteViewModalProps) {
  const [title, setTitle] = useState(note.title)
  const [content, setContent] = useState(note.content)
  const contentRef = useRef<HTMLTextAreaElement>(null)

  // Sync khi note thay đổi
  useEffect(() => {
    setTitle(note.title)
    setContent(note.content)
  }, [note])

  // Auto-focus textarea khi mở
  useEffect(() => {
    if (open) {
      setTimeout(() => contentRef.current?.focus(), 80)
    }
  }, [open])

  // Đóng bằng Escape
  useEffect(() => {
    const handler = (e: KeyboardEvent) => {
      if (e.key === "Escape") onClose()
    }
    if (open) window.addEventListener("keydown", handler)
    return () => window.removeEventListener("keydown", handler)
  }, [open, onClose])

  const handleSave = () => {
    onSave(title, content)
  }

  return (
    <AnimatePresence>
      {open && (
        <>
          {/* Overlay */}
          <motion.div
            key="overlay"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            transition={{ duration: 0.18 }}
            className="fixed inset-0 z-50 bg-black/50 backdrop-blur-sm"
            onClick={onClose}
          />

          {/* Modal */}
          <motion.div
            key="modal"
            initial={{ opacity: 0, scale: 0.94, y: 20 }}
            animate={{ opacity: 1, scale: 1, y: 0 }}
            exit={{ opacity: 0, scale: 0.94, y: 20 }}
            transition={{ duration: 0.22, type: "spring", stiffness: 300, damping: 28 }}
            className="fixed inset-0 z-50 flex items-center justify-center p-4"
            onClick={(e) => e.stopPropagation()}
          >
            <div className="w-full max-w-2xl bg-card border border-border/60 rounded-2xl shadow-2xl flex flex-col overflow-hidden max-h-[90vh]">
              
              {/* Header */}
              <div className="flex items-center gap-3 px-5 py-4 border-b border-border/50 bg-muted/30">
                <span className="text-xs font-mono font-bold text-primary bg-primary/10 rounded-full px-2 py-0.5">
                  #{note.id}
                </span>
                <input
                  type="text"
                  value={title}
                  onChange={(e) => setTitle(e.target.value)}
                  placeholder="Tiêu đề ghi chú..."
                  className="flex-1 bg-transparent text-base font-semibold outline-none placeholder:text-muted-foreground/60 min-w-0"
                />
                <button
                  type="button"
                  onClick={onClose}
                  className="shrink-0 rounded-lg p-1.5 hover:bg-accent transition-colors text-muted-foreground hover:text-foreground"
                >
                  <X size={16} />
                </button>
              </div>

              {/* Textarea — nội dung chỉnh sửa như text bình thường */}
              <div className="flex-1 overflow-y-auto p-5">
                <textarea
                  ref={contentRef}
                  value={content}
                  onChange={(e) => setContent(e.target.value)}
                  placeholder="Nhập nội dung ghi chú...&#10;&#10;Bạn có thể xuống dòng tự do như trong một tài liệu văn bản."
                  className={[
                    "w-full h-full min-h-[300px] resize-none",
                    "bg-transparent text-sm leading-7 outline-none",
                    "placeholder:text-muted-foreground/50",
                    "font-[inherit] whitespace-pre-wrap",
                  ].join(" ")}
                />
              </div>

              {/* Footer */}
              <div className="flex items-center justify-end gap-2 px-5 py-3 border-t border-border/50 bg-muted/20">
                <Button type="button" variant="ghost" size="sm" onClick={onClose}>
                  Hủy
                </Button>
                <Button
                  type="button"
                  size="sm"
                  className="gap-1.5"
                  onClick={handleSave}
                >
                  <Save size={13} />
                  Lưu
                </Button>
              </div>
            </div>
          </motion.div>
        </>
      )}
    </AnimatePresence>
  )
}

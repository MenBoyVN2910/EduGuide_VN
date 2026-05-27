import { useEffect, useRef, useState } from "react"
import { X, Save, Copy, CheckCircle2, Trash2 } from "lucide-react"
import { motion, AnimatePresence } from "framer-motion"
import type { Note } from "./NotesContext"
import { Button } from "@/components/ui/button"
import { cn } from "@/lib/utils"

interface NoteViewModalProps {
  note: Note
  open: boolean
  onClose: () => void
  onSave: (title: string, content: string) => void
  onDelete?: (id: number) => void // Thêm option xóa từ modal
}

export function NoteViewModal({ note, open, onClose, onSave, onDelete }: NoteViewModalProps) {
  const [title, setTitle] = useState(note.title)
  const [content, setContent] = useState(note.content)
  const [copied, setCopied] = useState(false)
  const contentRef = useRef<HTMLTextAreaElement>(null)

  // Sync khi note thay đổi (e.g. cập nhật từ card hoặc context)
  useEffect(() => {
    if (note) {
      setTitle(note.title)
      setContent(note.content)
    }
  }, [note])

  // Auto-focus khi mở
  useEffect(() => {
    if (open) {
      const timer = setTimeout(() => contentRef.current?.focus(), 150)
      return () => clearTimeout(timer)
    }
  }, [open])

  // Phím tắt Escape
  useEffect(() => {
    const handleEsc = (e: KeyboardEvent) => {
      if (e.key === "Escape") onClose()
    }
    if (open) window.addEventListener("keydown", handleEsc)
    return () => window.removeEventListener("keydown", handleEsc)
  }, [open, onClose])

  const handleSave = () => {
    onSave(title, content)
    onClose()
  }

  const handleCopy = () => {
    navigator.clipboard.writeText(content)
    setCopied(true)
    setTimeout(() => setCopied(false), 2000)
  }

  return (
    <AnimatePresence>
      {open && (
        <>
          {/* Backdrop mượt mà */}
          <motion.div
            key="overlay"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            className="fixed inset-0 z-50 bg-black/60 backdrop-blur-[3px]"
            onClick={onClose}
          />

          {/* Modal Container */}
          <motion.div
            key="modal"
            initial={{ opacity: 0, scale: 0.95, y: 30 }}
            animate={{ opacity: 1, scale: 1, y: 0 }}
            exit={{ opacity: 0, scale: 0.95, y: 30 }}
            transition={{ type: "spring", stiffness: 350, damping: 30, mass: 0.8 }}
            className="fixed inset-0 z-50 flex items-center justify-center p-4 md:p-6"
            onClick={(e) => e.stopPropagation()}
          >
            <div className="w-full max-w-3xl bg-card border border-border shadow-[0_30px_60px_-15px_rgba(0,0,0,0.5)] rounded-[28px] flex flex-col overflow-hidden max-h-[85vh] animate-in zoom-in-95 duration-200">
              
              {/* Header Editor - Thanh tiêu đề */}
              <div className="flex items-center gap-4 px-6 md:px-8 py-5 border-b border-border/40 bg-muted/20">
                <div className="shrink-0 h-8 w-8 rounded-xl bg-primary/10 flex items-center justify-center text-primary font-bold text-xs">
                  #{note.id}
                </div>
                <input
                  type="text"
                  value={title}
                  onChange={(e) => setTitle(e.target.value)}
                  placeholder="Nhập tiêu đề..."
                  className="flex-1 bg-transparent text-lg font-bold outline-none placeholder:text-muted-foreground/40 min-w-0"
                />
                
                <div className="flex items-center gap-1">
                   <Button
                      variant="ghost"
                      size="icon"
                      className="h-9 w-9 rounded-full text-muted-foreground hover:bg-muted"
                      onClick={handleCopy}
                      title="Sao chép toàn bộ"
                   >
                     {copied ? <CheckCircle2 size={18} className="text-green-500" /> : <Copy size={18} />}
                   </Button>
                   <Button
                      variant="ghost"
                      size="icon"
                      className="h-9 w-9 rounded-full text-muted-foreground hover:text-foreground hover:bg-muted"
                      onClick={onClose}
                   >
                     <X size={20} />
                   </Button>
                </div>
              </div>

              {/* Main Content — Distortion free focused typing area */}
              <div className="flex-1 overflow-y-auto px-6 md:px-8 py-6 custom-scrollbar">
                <textarea
                  ref={contentRef}
                  value={content}
                  onChange={(e) => setContent(e.target.value)}
                  placeholder="Bắt đầu nhập nội dung ghi chú của bạn tại đây...&#10;&#10;Sử dụng Enter để xuống dòng. Hệ thống tự động căn chỉnh và giữ định dạng cho bạn."
                  className={cn(
                    "w-full h-full min-h-[350px] resize-none",
                    "bg-transparent text-[15px] leading-[1.8] outline-none",
                    "placeholder:text-muted-foreground/30",
                    "font-[inherit] whitespace-pre-wrap selection:bg-primary/20",
                  )}
                />
              </div>

              {/* Action Footer */}
              <div className="flex items-center justify-between gap-3 px-6 md:px-8 py-4 border-t border-border/40 bg-muted/10">
                <div className="flex gap-2">
                   {onDelete && (
                      <Button
                        type="button"
                        variant="ghost"
                        size="sm"
                        className="h-9 rounded-xl px-4 text-muted-foreground hover:text-destructive hover:bg-destructive/10"
                        onClick={() => {
                           onDelete(note.id);
                           onClose();
                        }}
                      >
                        <Trash2 size={15} />
                      </Button>
                   )}
                </div>
                
                <div className="flex items-center gap-3">
                  <Button 
                    type="button" 
                    variant="ghost" 
                    className="h-10 rounded-xl px-6 text-sm font-medium" 
                    onClick={onClose}
                  >
                    Hủy
                  </Button>
                  <Button
                    type="button"
                    className="h-10 rounded-xl px-7 gap-2 font-bold shadow-lg shadow-primary/20"
                    onClick={handleSave}
                  >
                    <Save size={16} />
                    Lưu thay đổi
                  </Button>
                </div>
              </div>
            </div>
          </motion.div>
        </>
      )}
    </AnimatePresence>
  )
}

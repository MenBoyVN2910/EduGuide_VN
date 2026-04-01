import { useState } from "react"
import { Copy, FileText, Trash2, CheckCircle2 } from "lucide-react"
import { motion, AnimatePresence } from "framer-motion"
import type { Note } from "./NotesContext"
import { NoteViewModal } from "./NoteViewModal"
import { Button } from "@/components/ui/button"
import { cn } from "@/lib/utils"

interface NoteCardProps {
  note: Note
  onDelete: (id: number) => void
  onUpdate: (id: number, title: string, content: string) => void
}

export function NoteCard({ note, onDelete, onUpdate }: NoteCardProps) {
  const [modalOpen, setModalOpen] = useState(false)
  const [copied, setCopied] = useState(false)

  // Preview nội dung (ngắt dòng hợp lý)
  const preview = note.content
    ? note.content.slice(0, 100) + (note.content.length > 100 ? "…" : "")
    : "Không có nội dung"

  const handleCopy = (e: React.MouseEvent) => {
    e.stopPropagation()
    navigator.clipboard.writeText(note.content || "")
    setCopied(true)
    setTimeout(() => setCopied(false), 2000)
  }

  // Định dạng ngày
  const dateStr = new Date(note.updatedAt).toLocaleDateString("vi-VN", {
     day: "2-digit",
     month: "2-digit",
     year: "numeric"
  })

  return (
    <>
      <motion.div
        layout
        initial={{ opacity: 0, y: 20, scale: 0.98 }}
        animate={{ opacity: 1, y: 0, scale: 1 }}
        exit={{ opacity: 0, scale: 0.95, transition: { duration: 0.15 } }}
        whileHover={{ y: -4, transition: { duration: 0.2 } }}
        className={cn(
          "group relative flex flex-col h-[200px] rounded-[22px] border border-border/60 bg-card p-6 shadow-sm hover:shadow-xl hover:border-primary/20 cursor-pointer overflow-hidden transition-all duration-300",
        )}
        onClick={() => setModalOpen(true)}
      >
        {/* Decorative corner accent */}
        <div className="absolute top-0 right-0 w-24 h-24 bg-primary/5 blur-3xl -mr-10 -mt-10 group-hover:bg-primary/10 transition-colors pointer-events-none" />

        {/* Index Badge */}
        <div className="absolute top-6 right-6 opacity-40 group-hover:opacity-100 transition-opacity">
          <span className="text-[10px] font-bold tracking-widest text-muted-foreground uppercase bg-muted px-2 py-0.5 rounded-full border border-border/50">
            #{note.id}
          </span>
        </div>

        {/* Header Content */}
        <div className="flex items-start gap-4 mb-4">
          <div className="shrink-0 flex items-center justify-center h-10 w-10 rounded-xl bg-primary/5 text-primary group-hover:scale-110 transition-transform duration-300 ring-1 ring-primary/10">
            <FileText size={20} strokeWidth={2.5} />
          </div>
          <div className="flex-1 min-w-0">
            <h3 className="font-bold text-[17px] leading-tight text-foreground/90 group-hover:text-primary transition-colors line-clamp-1">
              {note.title}
            </h3>
            <span className="text-[11px] text-muted-foreground font-medium mt-1 inline-block">
              {dateStr}
            </span>
          </div>
        </div>

        {/* Content Preview */}
        <p className="flex-1 text-sm text-muted-foreground/80 leading-relaxed overflow-hidden line-clamp-3 italic">
          "{preview}"
        </p>

        {/* Action Layer — Visible on Hover */}
        <div className="absolute inset-x-0 bottom-0 p-4 bg-gradient-to-t from-card via-card/90 to-transparent flex items-center justify-between opacity-0 group-hover:opacity-100 translate-y-2 group-hover:translate-y-0 transition-all duration-300">
           <div className="flex items-center gap-1">
              <Button
                type="button"
                variant="ghost"
                size="sm"
                className="h-8 rounded-lg text-xs font-bold gap-1.5 hover:bg-primary/10 hover:text-primary"
                onClick={handleCopy}
              >
                <AnimatePresence mode="wait" initial={false}>
                  {copied ? (
                    <motion.div 
                      key="checked" 
                      initial={{ scale: 0.5, opacity: 0 }} 
                      animate={{ scale: 1, opacity: 1 }} 
                      exit={{ scale: 0.5, opacity: 0 }}
                      className="flex items-center gap-1 text-green-500"
                    >
                      <CheckCircle2 size={13} />
                      Đã lưu
                    </motion.div>
                  ) : (
                    <motion.div 
                      key="copy" 
                      initial={{ scale: 0.5, opacity: 0 }} 
                      animate={{ scale: 1, opacity: 1 }} 
                      exit={{ scale: 0.5, opacity: 0 }}
                      className="flex items-center gap-1"
                    >
                      <Copy size={13} />
                      Sao chép
                    </motion.div>
                  )
                  }
                </AnimatePresence>
              </Button>
           </div>
           
           <div className="flex items-center gap-1">
              <Button
                type="button"
                variant="ghost"
                size="icon"
                className="h-8 w-8 rounded-lg hover:bg-destructive/10 hover:text-destructive"
                onClick={(e) => {
                  e.stopPropagation();
                  onDelete(note.id);
                }}
              >
                <Trash2 size={14} />
              </Button>
           </div>
        </div>
      </motion.div>

      <NoteViewModal
        note={note}
        open={modalOpen}
        onClose={() => setModalOpen(false)}
        onSave={(title: string, content: string) => {
          onUpdate(note.id, title, content)
        }}
        onDelete={onDelete}
      />
    </>
  )
}

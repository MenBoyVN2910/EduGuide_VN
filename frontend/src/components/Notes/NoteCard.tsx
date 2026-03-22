import { useState } from "react"
import { FileText, Pencil, Trash2 } from "lucide-react"
import { motion } from "framer-motion"
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

  // Preview nội dung (1 dòng)
  const preview = note.content
    ? note.content.slice(0, 80) + (note.content.length > 80 ? "…" : "")
    : "Chưa có nội dung"

  return (
    <>
      <motion.div
        layout
        initial={{ opacity: 0, y: 16, scale: 0.97 }}
        animate={{ opacity: 1, y: 0, scale: 1 }}
        exit={{ opacity: 0, scale: 0.95, y: -8 }}
        transition={{ duration: 0.25, type: "spring", stiffness: 260, damping: 22 }}
        className={cn(
          "group relative flex flex-col gap-3 rounded-2xl border bg-card p-5 shadow-sm",
          "hover:shadow-md hover:border-primary/30 transition-all",
        )}
      >
        {/* Số thứ tự */}
        <span className="absolute top-4 right-4 text-xs font-mono font-bold text-primary/60 bg-primary/10 rounded-full px-2 py-0.5">
          #{note.id}
        </span>

        {/* Header */}
        <div className="flex items-start gap-3 pr-10">
          <div className="mt-0.5 shrink-0 rounded-xl bg-primary/10 p-2 text-primary">
            <FileText size={16} />
          </div>
          <h3 className="font-semibold text-base leading-snug line-clamp-2 flex-1">
            {note.title}
          </h3>
        </div>

        {/* Preview nội dung */}
        <p className="text-sm text-muted-foreground leading-relaxed pl-11 line-clamp-2 whitespace-pre-line">
          {preview}
        </p>

        {/* Actions */}
        <div className="flex items-center justify-between pt-1 pl-11">
          <Button
            type="button"
            variant="outline"
            size="sm"
            className="gap-1.5 text-xs h-8 rounded-lg hover:border-primary/50 hover:text-primary"
            onClick={() => setModalOpen(true)}
          >
            <Pencil size={12} />
            Xem &amp; Sửa
          </Button>

          <Button
            type="button"
            variant="ghost"
            size="icon"
            className="h-8 w-8 rounded-lg opacity-0 group-hover:opacity-100 transition-opacity text-muted-foreground hover:text-destructive hover:bg-destructive/10"
            onClick={() => onDelete(note.id)}
            title="Xóa ghi chú"
          >
            <Trash2 size={14} />
          </Button>
        </div>
      </motion.div>

      <NoteViewModal
        note={note}
        open={modalOpen}
        onClose={() => setModalOpen(false)}
        onSave={(title: string, content: string) => {
          onUpdate(note.id, title, content)
          setModalOpen(false)
        }}
      />
    </>
  )
}

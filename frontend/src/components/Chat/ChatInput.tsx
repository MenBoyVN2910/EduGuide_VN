import React, { useRef, useEffect } from "react"
import { Send, Sparkles } from "lucide-react"
import { Button } from "@/components/ui/button"

interface ChatInputProps {
  onSend: (message: string) => void
  isLoading?: boolean
}

const ChatInput: React.FC<ChatInputProps> = ({ onSend, isLoading }) => {
  const [input, setInput] = React.useState("")
  const textareaRef = useRef<HTMLTextAreaElement>(null)

  const resizeTextarea = () => {
    const textarea = textareaRef.current
    if (textarea) {
      textarea.style.height = "auto"
      textarea.style.height = `${Math.min(textarea.scrollHeight, 200)}px`
    }
  }

  useEffect(() => {
    resizeTextarea()
  }, [input])

  const handleKeyDown = (e: React.KeyboardEvent<HTMLTextAreaElement>) => {
    if (e.key === "Enter" && !e.shiftKey) {
      e.preventDefault()
      handleSend()
    }
  }

  const handleSend = () => {
    if (input.trim() && !isLoading) {
      onSend(input.trim())
      setInput("")
      if (textareaRef.current) {
        textareaRef.current.style.height = "auto"
      }
    }
  }

  return (
    <div className="relative mx-auto flex w-full max-w-4xl flex-col gap-2 px-4 md:px-8">
      <div className="group relative flex w-full items-end overflow-hidden rounded-[2rem] border border-slate-200 dark:border-slate-800 bg-white dark:bg-card focus-within:ring-2 focus-within:ring-blue-500/30 focus-within:border-blue-400 shadow-lg shadow-slate-200/50 dark:shadow-none transition-all duration-300">
        <textarea
          ref={textareaRef}
          value={input}
          onChange={(e) => setInput(e.target.value)}
          onKeyDown={handleKeyDown}
          placeholder="Hỏi AI về chương trình đào tạo, môn học tiên quyết..."
          className="max-h-[200px] min-h-[56px] w-full resize-none border-0 bg-transparent py-4 pl-6 pr-14 text-sm focus:ring-0 focus-visible:ring-0 outline-none placeholder:text-slate-400"
          rows={1}
          disabled={isLoading}
        />
        <Button
          size="icon"
          disabled={!input.trim() || isLoading}
          onClick={handleSend}
          className="absolute right-2 bottom-1.5 h-10 w-10 rounded-full transition-all z-10 bg-blue-600 hover:bg-blue-700 text-white shadow-md group-focus-within:bg-blue-600"
        >
          {isLoading ? (
            <Sparkles className="h-5 w-5 animate-pulse" />
          ) : (
            <Send className="h-4 w-4 shrink-0 translate-x-[1px]" />
          )}
        </Button>
      </div>
      <div className="text-center text-xs text-slate-500 dark:text-muted-foreground pb-2 font-medium">
        ChatBoxAI có thể mắc lỗi. Vui lòng kiểm tra lại thông tin quan trọng với nhà trường.
      </div>
    </div>
  )
}

export default ChatInput

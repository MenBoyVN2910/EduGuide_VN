import React, { useEffect, useRef } from "react"
import ChatMessage, { ChatMessageProps } from "./ChatMessage"
import { Sparkles, BookOpen, Clock, Lightbulb } from "lucide-react"

interface MessageListProps {
  messages: ChatMessageProps[]
  onSuggestClick: (text: string) => void
}

const SUGGESTIONS = [
  { icon: BookOpen, text: "Chương trình đào tạo ngành CNTT gồm những môn nào?" },
  { icon: Clock, text: "Môn tiên quyết của Cấu trúc dữ liệu và Thuật toán là gì?" },
  { icon: Lightbulb, text: "Gợi ý lộ trình học Trí tuệ Nhân tạo chuẩn nhất?" },
  { icon: Sparkles, text: "Tôi cần học những môn tự chọn nào để nắm vững Web?" }
]

const MessageList: React.FC<MessageListProps> = ({ messages, onSuggestClick }) => {
  const bottomRef = useRef<HTMLDivElement>(null)

  // Auto scroll to bottom
  useEffect(() => {
    if (bottomRef.current) {
      bottomRef.current.scrollIntoView({ behavior: "smooth" })
    }
  }, [messages])

  return (
    <div className="flex-1 w-full overflow-y-auto bg-slate-50/50 dark:bg-background/95">
      {messages.length === 0 ? (
        <div className="flex h-full flex-col items-center justify-center p-8 text-center text-muted-foreground animate-in fade-in duration-700">
          <div className="mb-6 rounded-full bg-gradient-to-tr from-blue-500 to-indigo-600 p-5 shadow-lg shadow-blue-500/30">
            <Sparkles className="h-10 w-10 text-white" />
          </div>
          <h2 className="text-3xl md:text-4xl font-bold tracking-tight mb-4 bg-gradient-to-r from-blue-600 to-indigo-600 bg-clip-text text-transparent">
            Xin chào! 👋
          </h2>
          <p className="max-w-xl text-lg mb-10 text-slate-600 dark:text-slate-400">
            Tôi là trợ lý AI ảo giúp bạn trả lời các câu hỏi về chương trình đào tạo, môn học tiên quyết và gợi ý lộ trình học tập tối ưu.
          </p>
          
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4 max-w-3xl w-full px-4">
            {SUGGESTIONS.map((s, i) => (
              <button
                key={i}
                onClick={() => onSuggestClick(s.text)}
                className="flex items-center gap-4 p-4 rounded-2xl border border-slate-200 dark:border-border/50 bg-white dark:bg-card hover:bg-blue-50/50 dark:hover:bg-accent hover:border-blue-300 dark:hover:border-primary/30 transition-all text-left group shadow-sm hover:shadow-md"
              >
                <div className="bg-blue-100 dark:bg-primary/10 p-2.5 rounded-xl text-blue-600 dark:text-primary group-hover:scale-110 transition-transform">
                  <s.icon className="w-5 h-5" />
                </div>
                <span className="text-sm font-medium text-slate-700 dark:text-foreground/80 group-hover:text-blue-700 dark:group-hover:text-foreground">
                  {s.text}
                </span>
              </button>
            ))}
          </div>
        </div>
      ) : (
        <div className="flex flex-col pb-8 pt-4">
          {messages.map((msg) => (
            <ChatMessage key={msg.id} role={msg.role} content={msg.content} id={msg.id} />
          ))}
          <div ref={bottomRef} className="h-4" />
        </div>
      )}
    </div>
  )
}

export default MessageList

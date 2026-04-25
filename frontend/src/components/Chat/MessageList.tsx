import React, { useEffect, useRef } from "react"
import type { ChatMessageProps } from "./ChatMessage"
import ChatMessage from "./ChatMessage"
import { BookOpen, GraduationCap, Link2, Search } from "lucide-react"

interface MessageListProps {
  messages: ChatMessageProps[]
  onSendMessage?: (text: string) => void
}

const SAMPLES = [
  {
    icon: <BookOpen className="h-4 w-4 text-blue-500" />,
    title: "Thông tin tổng quan",
    description: "Tra cứu thông tin chung về ngành CNTT.",
    text: "Ngành CNTT học bao nhiêu năm và có bao nhiêu tín chỉ?"
  },
  {
    icon: <Search className="h-4 w-4 text-orange-500" />,
    title: "Tra cứu chi tiết",
    description: "Tìm hiểu thông số cụ thể của từng môn học.",
    text: "Môn Lập trình hướng đối tượng có bao nhiêu tín chỉ?"
  },
  {
    icon: <Link2 className="h-4 w-4 text-purple-500" />,
    title: "Điều kiện tiên quyết",
    description: "Kiểm tra các môn học cần hoàn thành trước.",
    text: "Để học môn Lập trình Web thì cần hoàn thành môn nào trước?"
  },
  {
    icon: <GraduationCap className="h-4 w-4 text-emerald-500" />,
    title: "Tư vấn & Gợi ý",
    description: "Nhận lời khuyên chọn môn học theo lộ trình.",
    text: "Học kỳ này mình muốn học nhẹ, hãy gợi ý cho mình 3 môn ít tín chỉ nhất."
  }
]

const MessageList: React.FC<MessageListProps> = ({ messages, onSendMessage }) => {
  const bottomRef = useRef<HTMLDivElement>(null)

  useEffect(() => {
    if (bottomRef.current) {
      bottomRef.current.scrollIntoView({ behavior: "smooth" })
    }
  }, [messages])

  return (
    <div className="flex-1 w-full overflow-y-auto bg-background text-foreground custom-scrollbar">
      {messages.length === 0 ? (
        <div className="flex h-full flex-col items-center justify-center p-6 md:p-8 animate-in fade-in slide-in-from-bottom-4 duration-700">
          <div className="mb-8 text-center max-w-2xl px-4">
            <h2 className="text-3xl font-extrabold tracking-tight mb-3 text-foreground/90 leading-tight">
              Chào bạn <span className="inline-block animate-bounce">👋</span>
            </h2>
            <p className="text-muted-foreground text-lg font-medium">
              Tôi là trợ lý ảo EduGuide. Tôi có thể giúp gì cho việc học của bạn hôm nay?
            </p>
          </div>

          <div className="grid grid-cols-1 sm:grid-cols-2 gap-4 w-full max-w-2xl">
            {SAMPLES.map((sample, idx) => (
              <button
                key={idx}
                onClick={() => onSendMessage?.(sample.text)}
                className="flex flex-col items-start text-left p-5 rounded-[22px] border border-border/60 bg-muted/30 hover:bg-muted/50 hover:border-primary/30 hover:shadow-md transition-all group relative overflow-hidden"
              >
                 <div className="absolute top-0 right-0 w-16 h-16 bg-primary/5 blur-2xl -mr-8 -mt-8 group-hover:bg-primary/10 transition-colors" />
                 <div className="flex items-center gap-3 mb-2">
                    <div className="p-2 rounded-xl bg-background shadow-sm ring-1 ring-border group-hover:ring-primary/20 transition-all">
                       {sample.icon}
                    </div>
                    <span className="font-bold text-[15px] text-foreground/80 group-hover:text-primary transition-colors">
                       {sample.title}
                    </span>
                 </div>
                 <p className="text-xs text-muted-foreground leading-relaxed">
                   {sample.description}
                 </p>
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

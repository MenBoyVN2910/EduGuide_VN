import { useRef, useState } from "react"
import MessageList from "./MessageList"
import ChatInput from "./ChatInput"
import type { ChatMessageProps } from "./ChatMessage"
import { useChatHistory } from "./ChatHistoryContext"

const ChatInterface = () => {
  const { activeId, activeConversation, updateConversation } = useChatHistory()
  const [isLoading, setIsLoading] = useState(false)
  const prevActiveId = useRef(activeId)

  // Messages đến từ conversation đang active
  const messages: ChatMessageProps[] = activeConversation?.messages ?? []

  // Reset loading state khi chuyển conversation (dùng ref tránh lint)
  if (prevActiveId.current !== activeId) {
    prevActiveId.current = activeId
    setIsLoading(false)
  }

  const handleSendMessage = async (text: string) => {
    if (!activeId) return

    const newUserMsg: ChatMessageProps = {
      id: Date.now().toString(),
      role: "user",
      content: text,
    }

    const updatedMessages = [...messages, newUserMsg]
    updateConversation(activeId, updatedMessages)
    setIsLoading(true)

    try {
      // Gọi API thực tế tới Backend FastAPI
      const response = await fetch(
        `${import.meta.env.VITE_API_URL || "http://localhost:8000"}/api/v1/chatbot/chat`,
        {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ messages: updatedMessages }),
        },
      )

      if (!response.ok) throw new Error("API Route error")

      const data = await response.json()
      const aiResponse: ChatMessageProps = {
        id: (Date.now() + 1).toString(),
        role: "assistant",
        content: data.reply,
      }
      updateConversation(activeId, [...updatedMessages, aiResponse])
    } catch (error) {
      console.error(error)
      const errorResponse: ChatMessageProps = {
        id: (Date.now() + 1).toString(),
        role: "assistant",
        content: "Xin lỗi, đã xảy ra lỗi kết nối đến Backend AI.",
      }
      updateConversation(activeId, [...updatedMessages, errorResponse])
    } finally {
      setIsLoading(false)
    }
  }

  return (
    <div className="flex h-full w-full flex-col overflow-hidden bg-slate-50/30 dark:bg-background">
      <MessageList messages={messages} onSuggestClick={handleSendMessage} />
      <div className="w-full bg-gradient-to-t from-slate-50 dark:from-background via-slate-50/80 dark:via-background/80 to-transparent pt-8 pb-4">
        <ChatInput onSend={handleSendMessage} isLoading={isLoading} />
      </div>
    </div>
  )
}

export default ChatInterface

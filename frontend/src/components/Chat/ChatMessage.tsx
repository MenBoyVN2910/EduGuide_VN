import type React from "react"
import ReactMarkdown from "react-markdown"
import remarkGfm from "remark-gfm"
import { Copy, RefreshCcw, Volume2 } from "lucide-react"
import { motion } from "framer-motion"
import { cn } from "@/lib/utils"

export type MessageRole = "user" | "assistant"

export interface ChatMessageProps {
  id: string
  role: MessageRole
  content: string
}

const ChatMessage: React.FC<ChatMessageProps> = ({ role, content }) => {
  const isUser = role === "user"

  return (
    <motion.div
      initial={{ opacity: 0, y: 10, scale: 0.98 }}
      animate={{ opacity: 1, y: 0, scale: 1 }}
      transition={{ duration: 0.3, type: "spring", stiffness: 200, damping: 20 }}
      className={cn(
        "flex w-full px-4 py-4 md:px-5 group",
        !isUser && "bg-transparent"
      )}
    >
      <div className={cn(
          "mx-auto flex w-full max-w-[800px] gap-4 md:gap-5 text-[15px] leading-relaxed",
          isUser && "flex-row-reverse"
        )}>
        {/* Avatar */}
        <div className="shrink-0 mt-0.5">
          {!isUser && (
            <div className="flex h-7 w-7 items-center justify-center rounded-full border border-border bg-white dark:bg-white p-1 shadow-sm">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" className="text-black h-4 w-4" aria-hidden="true">
                  <path d="M22.28 11.2a5.53 5.53 0 0 0-1.78-4.43c-1.32-1.2-3.1-1.63-4.83-1.18V5.5A5.85 5.85 0 0 0 9.82 2.76 5.85 5.85 0 0 0 4.1 6.5C2.53 7.37 1.63 9 1.63 10.79V12A5.85 5.85 0 0 0 6 17.5c1.46.68 3.16.59 4.54-.23v1.23a5.85 5.85 0 0 0 6.13 2.74c1.68-.45 3.01-1.78 3.46-3.46a5.85 5.85 0 0 0-.25-4.48c1.32-1.2 1.65-3.04 2.4-4.1z" fill="currentColor"/>
                </svg>
            </div>
          )}
        </div>

        {/* Content */}
        <div className={cn(
             "flex flex-col gap-2 max-w-[85%] md:max-w-[75%]",
             isUser ? "bg-muted text-foreground rounded-3xl px-5 py-2.5" : "text-foreground mt-1"
          )}>
          {isUser ? (
             <div className="whitespace-pre-wrap">{content}</div>
          ) : (
             <>
                <div className="prose-sm md:prose-base dark:prose-invert max-w-none space-y-3 prose-p:leading-relaxed prose-headings:font-semibold prose-a:text-blue-500 dark:prose-a:text-blue-400">
                   <ReactMarkdown 
                     remarkPlugins={[remarkGfm]}
                     components={{
                       table: ({node, ...props}) => <div className="overflow-x-auto my-4"><table className="min-w-full divide-y divide-border border border-border rounded-lg" {...props} /></div>,
                       thead: ({node, ...props}) => <thead className="bg-muted" {...props} />,
                       th: ({node, ...props}) => <th className="px-4 py-3 text-left text-xs font-semibold uppercase tracking-wider text-muted-foreground" {...props} />,
                       td: ({node, ...props}) => <td className="px-4 py-3 border-t border-border text-sm" {...props} />,
                       a: ({node, ...props}) => <a className="text-blue-500 dark:text-blue-400 hover:text-blue-600 dark:hover:text-blue-300 hover:underline font-medium" {...props} />,
                       code: ({node, ...props}) => <code className="bg-muted px-1.5 py-0.5 rounded text-sm font-mono" {...props} />,
                     }}
                   >
                     {content}
                   </ReactMarkdown>
                </div>
                <div className="mt-1 flex items-center gap-2 text-muted-foreground opacity-0 group-hover:opacity-100 transition-opacity">
                   <button type="button" className="rounded p-1.5 hover:bg-muted hover:text-foreground" aria-label="Đọc văn bản" title="Đọc văn bản">
                     <Volume2 className="h-4 w-4" />
                   </button>
                   <button type="button" className="rounded p-1.5 hover:bg-muted hover:text-foreground" aria-label="Sao chép" title="Sao chép">
                     <Copy className="h-4 w-4" />
                   </button>
                   <button type="button" className="rounded p-1.5 hover:bg-muted hover:text-foreground" aria-label="Tạo lại" title="Tạo lại">
                     <RefreshCcw className="h-4 w-4" />
                   </button>
                </div>
             </>
          )}
        </div>
      </div>
    </motion.div>
  )
}

export default ChatMessage


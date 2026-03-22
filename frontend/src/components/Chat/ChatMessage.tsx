import React from "react"
import ReactMarkdown from "react-markdown"
import remarkGfm from "remark-gfm"
import { User, Bot } from "lucide-react"
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
        "flex w-full px-4 py-4 md:px-8",
        !isUser && "bg-transparent"
      )}
    >
      <div className={cn(
          "mx-auto flex w-full max-w-4xl gap-4 md:gap-5",
          isUser && "flex-row-reverse"
        )}>
        {/* Avatar */}
        <div className="flex-shrink-0 mt-1">
          <div
            className={cn(
               "flex h-9 w-9 items-center justify-center rounded-full shadow-sm ring-2 ring-white dark:ring-background/20",
               isUser ? "bg-blue-600 text-white" : "bg-gradient-to-br from-indigo-500 to-blue-600 text-white"
            )}
          >
            {isUser ? <User size={18} /> : <Bot size={18} />}
          </div>
        </div>

        {/* Content */}
        <div className={cn(
             "px-5 py-4 rounded-3xl flex-1 max-w-[85%] md:max-w-[75%]",
             isUser ? "bg-blue-600 text-white shadow-md rounded-tr-sm" : "bg-white dark:bg-card border border-slate-100 dark:border-border/40 shadow-sm rounded-tl-sm text-slate-800 dark:text-foreground"
          )}>
          {isUser ? (
             <div className="whitespace-pre-wrap text-sm md:text-base font-medium">{content}</div>
          ) : (
            <div className="prose-sm md:prose-base dark:prose-invert max-w-none space-y-3 prose-p:leading-relaxed prose-headings:font-semibold prose-a:text-blue-600">
               <ReactMarkdown 
                 remarkPlugins={[remarkGfm]}
                 components={{
                   table: ({node, ...props}) => <div className="overflow-x-auto my-4"><table className="min-w-full divide-y divide-slate-200 dark:divide-slate-800 border border-slate-200 dark:border-slate-800 rounded-lg shadow-sm" {...props} /></div>,
                   thead: ({node, ...props}) => <thead className="bg-slate-50 dark:bg-slate-800/50" {...props} />,
                   th: ({node, ...props}) => <th className="px-4 py-3 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider" {...props} />,
                   td: ({node, ...props}) => <td className="px-4 py-3 border-t border-slate-100 dark:border-slate-800 text-sm" {...props} />,
                   a: ({node, ...props}) => <a className="text-blue-600 hover:text-blue-800 hover:underline font-medium transition-colors" {...props} />,
                   code: ({node, ...props}) => <code className="bg-slate-100 dark:bg-slate-800 px-1.5 py-0.5 rounded text-sm font-mono text-blue-600 dark:text-blue-400" {...props} />,
                 }}
               >
                 {content}
               </ReactMarkdown>
            </div>
          )}
        </div>
      </div>
    </motion.div>
  )
}

export default ChatMessage

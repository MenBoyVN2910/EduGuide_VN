import { MessageSquare, Plus, Search, Trash2, X } from "lucide-react"
import { useState } from "react"
import { useNavigate } from "@tanstack/react-router"
import { useChatHistory } from "@/components/Chat/ChatHistoryContext"
import {
  SidebarGroup,
  SidebarGroupContent,
  SidebarGroupLabel,
  SidebarMenu,
  SidebarMenuAction,
  SidebarMenuButton,
  SidebarMenuItem,
  useSidebar,
} from "@/components/ui/sidebar"
import { cn } from "@/lib/utils"

export function ChatHistoryList() {
  const {
    conversations,
    activeId,
    createConversation,
    selectConversation,
    deleteConversation,
  } = useChatHistory()

  const navigate = useNavigate()
  const { isMobile, setOpenMobile, state } = useSidebar()
  const isCollapsed = state === "collapsed"

  const [search, setSearch] = useState("")
  const [showSearch, setShowSearch] = useState(false)

  const handleSelect = (id: string) => {
    selectConversation(id)
    navigate({ to: "/" })
    if (isMobile) setOpenMobile(false)
  }

  const handleDelete = (e: React.MouseEvent, id: string) => {
    e.stopPropagation()
    deleteConversation(id)
  }

  const handleNew = () => {
    createConversation()
    if (isMobile) setOpenMobile(false)
  }

  // Lọc cuộc trò chuyện theo từ khóa tìm kiếm (title + nội dung messages)
  const filteredConversations = search.trim()
    ? conversations.filter((conv) => {
        const q = search.toLowerCase()
        if (conv.title.toLowerCase().includes(q)) return true
        return conv.messages.some((m) => m.content.toLowerCase().includes(q))
      })
    : conversations

  const toggleSearch = () => {
    setShowSearch((prev) => {
      if (prev) setSearch("") // Reset search khi đóng
      return !prev
    })
  }

  return (
    <SidebarGroup className="flex-1 overflow-hidden flex flex-col min-h-0">
      {/* Header: Label + nút search */}
      <div className="flex items-center justify-between pr-1">
        <SidebarGroupLabel className="text-xs font-semibold text-muted-foreground uppercase tracking-wider mb-1">
          Lịch sử trò chuyện
        </SidebarGroupLabel>
        {!isCollapsed && (
          <button
            type="button"
            onClick={toggleSearch}
            className={cn(
              "p-1 rounded-md transition-colors mb-1",
              showSearch
                ? "text-primary bg-primary/10"
                : "text-muted-foreground hover:text-foreground hover:bg-accent",
            )}
            title="Tìm kiếm cuộc trò chuyện"
          >
            {showSearch ? <X size={14} /> : <Search size={14} />}
          </button>
        )}
      </div>

      {/* Ô tìm kiếm — hiện khi showSearch = true */}
      {!isCollapsed && showSearch && (
        <div className="px-2 pb-2">
          <div className="relative">
            <Search className="absolute left-2.5 top-1/2 -translate-y-1/2 h-3.5 w-3.5 text-muted-foreground pointer-events-none" />
            <input
              type="text"
              value={search}
              onChange={(e) => setSearch(e.target.value)}
              placeholder="Tìm cuộc trò chuyện..."
              autoFocus
              className="w-full bg-muted/40 border border-border rounded-lg py-1.5 pl-8 pr-3 text-xs focus:bg-muted/10 transition-all outline-none focus:ring-1 focus:ring-primary/30 focus:border-primary/30 placeholder:text-muted-foreground/60"
            />
          </div>
        </div>
      )}

      <SidebarGroupContent className="overflow-y-auto flex-1">
        <SidebarMenu>
          {/* Nút tạo cuộc trò chuyện mới — dùng SidebarMenuButton để tự co lại */}
          <SidebarMenuItem>
            <SidebarMenuButton
              tooltip="Cuộc trò chuyện mới"
              onClick={handleNew}
              className="bg-primary/10 hover:bg-primary/20 text-primary font-medium"
            >
              <Plus size={15} className="shrink-0" />
              <span>Cuộc trò chuyện mới</span>
            </SidebarMenuButton>
          </SidebarMenuItem>

          {/* Danh sách conversations — ẩn khi icon mode vì không đủ chỗ */}
          {!isCollapsed && filteredConversations.map((conv) => {
            const isActive = conv.id === activeId
            return (
              <SidebarMenuItem key={conv.id} className="group/item relative">
                <SidebarMenuButton
                  isActive={isActive}
                  onClick={() => handleSelect(conv.id)}
                  className={cn(
                    "pr-8 truncate",
                    isActive && "font-medium",
                  )}
                  tooltip={conv.title}
                >
                  <MessageSquare
                    size={15}
                    className={cn(
                      "shrink-0",
                      isActive ? "text-primary" : "text-muted-foreground",
                    )}
                  />
                  <span className="truncate text-sm">{conv.title}</span>
                </SidebarMenuButton>

                {/* Nút xóa - hiện khi hover */}
                <SidebarMenuAction
                  onClick={(e) => handleDelete(e, conv.id)}
                  className="opacity-0 group-hover/item:opacity-100 transition-opacity hover:text-destructive hover:bg-destructive/10"
                  title="Xóa cuộc trò chuyện"
                >
                  <Trash2 size={14} />
                </SidebarMenuAction>
              </SidebarMenuItem>
            )
          })}

          {/* Không tìm thấy kết quả */}
          {!isCollapsed && search.trim() && filteredConversations.length === 0 && (
            <p className="px-3 py-4 text-xs text-muted-foreground text-center">
              Không tìm thấy cuộc trò chuyện nào
            </p>
          )}

          {!isCollapsed && !search.trim() && conversations.length === 0 && (
            <p className="px-3 py-4 text-xs text-muted-foreground text-center">
              Chưa có cuộc trò chuyện nào
            </p>
          )}
        </SidebarMenu>
      </SidebarGroupContent>
    </SidebarGroup>
  )
}

export default ChatHistoryList

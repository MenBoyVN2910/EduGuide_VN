import { MessageSquare, Plus, Trash2 } from "lucide-react"
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

  const { isMobile, setOpenMobile, state } = useSidebar()
  const isCollapsed = state === "collapsed"

  const handleSelect = (id: string) => {
    selectConversation(id)
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

  return (
    <SidebarGroup className="flex-1 overflow-hidden flex flex-col min-h-0">
      {/* Label — tự ẩn khi collapse bởi SidebarGroupLabel */}
      <SidebarGroupLabel className="text-xs font-semibold text-muted-foreground uppercase tracking-wider mb-1">
        Lịch sử trò chuyện
      </SidebarGroupLabel>

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
          {!isCollapsed && conversations.map((conv) => {
            const isActive = conv.id === activeId
            return (
              <SidebarMenuItem key={conv.id}>
                <SidebarMenuButton
                  isActive={isActive}
                  onClick={() => handleSelect(conv.id)}
                  className={cn(
                    "group/item pr-8 truncate",
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

          {!isCollapsed && conversations.length === 0 && (
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

import { createFileRoute, Outlet } from "@tanstack/react-router"

import { ChatHistoryProvider } from "@/components/Chat/ChatHistoryContext"
import AppSidebar from "@/components/Sidebar/AppSidebar"
import {
  SidebarInset,
  SidebarProvider,
  SidebarTrigger,
} from "@/components/ui/sidebar"
import { useCurrentUserId } from "@/hooks/useCurrentUserId"

export const Route = createFileRoute("/_layout")({
  component: Layout,
  beforeLoad: async () => {
    // Tạm thời tắt check đăng nhập để xem UI Chatbot khi chưa có Backend
  },
})

function Layout() {
  const userId = useCurrentUserId()

  // Chờ userId được load xong trước khi render — đảm bảo dữ liệu đúng tài khoản
  if (!userId) {
    return null
  }

  return (
    <ChatHistoryProvider userId={userId}>
      <SidebarProvider>
        <AppSidebar />
        <SidebarInset className="flex flex-col h-svh overflow-hidden">
          {/* Nút toggle sidebar — nổi ở góc trên trái */}
          <div className="absolute top-3 left-3 z-20">
            <SidebarTrigger className="text-muted-foreground hover:text-foreground hover:bg-accent rounded-lg" />
          </div>
          {/* Nội dung chiếm toàn bộ màn hình */}
          <div className="flex-1 overflow-hidden">
            <Outlet />
          </div>
        </SidebarInset>
      </SidebarProvider>
    </ChatHistoryProvider>
  )
}

export default Layout


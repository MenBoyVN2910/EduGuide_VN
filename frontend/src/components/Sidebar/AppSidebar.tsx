import { Home, StickyNote, Users, LogIn } from "lucide-react"
import { Link, useNavigate } from "@tanstack/react-router"

import { SidebarAppearance } from "@/components/Common/Appearance"
<<<<<<< HEAD
import { SidebarLanguageSwitcher } from "@/components/Common/LanguageSwitcher"
=======
>>>>>>> a49a2d64878229f1071c2e2e32f0d609a5bf0113
import { Logo } from "@/components/Common/Logo"
import { useChatHistory } from "@/components/Chat/ChatHistoryContext"
import {
  Sidebar,
  SidebarContent,
  SidebarFooter,
  SidebarHeader,
  SidebarMenu,
  SidebarMenuItem,
  SidebarMenuButton,
} from "@/components/ui/sidebar"
import useAuth from "@/hooks/useAuth"
import { type Item, Main } from "./Main"
import { User } from "./User"
import { ChatHistoryList } from "./ChatHistoryList"
<<<<<<< HEAD
import { useTranslation } from "react-i18next"
=======

const baseItems: Item[] = [
  { icon: Home, title: "Dashboard", path: "/" },
  { icon: StickyNote, title: "Ghi Chú", path: "/items" },
]
>>>>>>> a49a2d64878229f1071c2e2e32f0d609a5bf0113

export function AppSidebar() {
  const { user: currentUser } = useAuth()
  const { createConversation } = useChatHistory()
  const navigate = useNavigate()
<<<<<<< HEAD
  const { t } = useTranslation()

  const baseItems: Item[] = [
    { icon: Home, title: t("sidebar.dashboard"), path: "/" },
    { icon: StickyNote, title: t("sidebar.notes"), path: "/items" },
  ]

  const items = currentUser?.is_superuser
    ? [...baseItems, { icon: Users, title: t("sidebar.admin"), path: "/admin" }]
=======

  const items = currentUser?.is_superuser
    ? [...baseItems, { icon: Users, title: "Admin", path: "/admin" }]
>>>>>>> a49a2d64878229f1071c2e2e32f0d609a5bf0113
    : baseItems

  // Khi click logo → tạo cuộc trò chuyện mới + navigate về trang chat
  const handleLogoClick = () => {
    createConversation()
    navigate({ to: "/" })
  }

  return (
    <Sidebar collapsible="icon" variant="sidebar">
      <SidebarHeader className="px-4 py-6 group-data-[collapsible=icon]:px-2 group-data-[collapsible=icon]:justify-center">
        <Logo onClick={handleLogoClick} />
      </SidebarHeader>
      <SidebarContent className="flex flex-col overflow-hidden">
        <Main items={items} />
        <ChatHistoryList />
      </SidebarContent>
      <SidebarFooter>
<<<<<<< HEAD
        <SidebarLanguageSwitcher />
=======
>>>>>>> a49a2d64878229f1071c2e2e32f0d609a5bf0113
        <SidebarAppearance />
        {currentUser ? (
          <User user={currentUser} />
        ) : (
          <SidebarMenu>
            <SidebarMenuItem>
              <SidebarMenuButton asChild size="lg" className="hover:bg-sidebar-accent">
                <Link to="/login">
                  <div className="flex items-center gap-2.5 w-full min-w-0">
                    <div className="flex h-8 w-8 items-center justify-center rounded-full bg-blue-600 shrink-0 text-white shadow-sm ring-1 ring-black/10">
                      <LogIn className="h-4 w-4" />
                    </div>
                    <div className="flex flex-col items-start min-w-0">
<<<<<<< HEAD
                      <p className="text-sm font-semibold truncate w-full text-sidebar-foreground">{t("sidebar.login")}</p>
                      <p className="text-xs text-sidebar-foreground/50 truncate w-full">{t("sidebar.syncData")}</p>
=======
                      <p className="text-sm font-semibold truncate w-full text-sidebar-foreground">Đăng nhập</p>
                      <p className="text-xs text-sidebar-foreground/50 truncate w-full">Đồng bộ dữ liệu</p>
>>>>>>> a49a2d64878229f1071c2e2e32f0d609a5bf0113
                    </div>
                  </div>
                </Link>
              </SidebarMenuButton>
            </SidebarMenuItem>
          </SidebarMenu>
        )}
      </SidebarFooter>
    </Sidebar>
  )
}

export default AppSidebar

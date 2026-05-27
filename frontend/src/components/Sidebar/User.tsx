import { Link as RouterLink } from "@tanstack/react-router"
import { ChevronsUpDown, LogOut, Settings } from "lucide-react"
<<<<<<< HEAD
import { useTranslation } from "react-i18next"
=======
>>>>>>> a49a2d64878229f1071c2e2e32f0d609a5bf0113

import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar"
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu"
import {
  SidebarMenu,
  SidebarMenuButton,
  SidebarMenuItem,
  useSidebar,
} from "@/components/ui/sidebar"
import useAuth from "@/hooks/useAuth"
import { useCurrentUserId } from "@/hooks/useCurrentUserId"
import { loadAvatar } from "@/components/UserSettings/AvatarUpload"
import { getInitials } from "@/utils"

interface UserInfoProps {
  fullName?: string
  email?: string
  avatarUrl?: string | null
}

function UserInfo({ fullName, email, avatarUrl }: UserInfoProps) {
<<<<<<< HEAD
  const { t } = useTranslation()
=======
>>>>>>> a49a2d64878229f1071c2e2e32f0d609a5bf0113
  return (
    <div className="flex items-center gap-2.5 w-full min-w-0">
      <Avatar className="size-8">
        {avatarUrl && (
          <AvatarImage src={avatarUrl} alt="Avatar" className="object-cover" />
        )}
        <AvatarFallback className="bg-zinc-600 text-white">
<<<<<<< HEAD
          {getInitials(fullName || t("user.defaultName"))}
=======
          {getInitials(fullName || "User")}
>>>>>>> a49a2d64878229f1071c2e2e32f0d609a5bf0113
        </AvatarFallback>
      </Avatar>
      <div className="flex flex-col items-start min-w-0">
        <p className="text-sm font-medium truncate w-full">{fullName}</p>
        <p className="text-xs text-muted-foreground truncate w-full">{email}</p>
      </div>
    </div>
  )
}

export function User({ user }: { user: any }) {
<<<<<<< HEAD
  const { t } = useTranslation()
=======
>>>>>>> a49a2d64878229f1071c2e2e32f0d609a5bf0113
  const { logout } = useAuth()
  const { isMobile, setOpenMobile } = useSidebar()
  const userId = useCurrentUserId()

  // Load avatar từ localStorage
  const avatarUrl = userId ? loadAvatar(userId) : null

  if (!user) return null

  const handleMenuClick = () => {
    if (isMobile) {
      setOpenMobile(false)
    }
  }
  const handleLogout = async () => {
    logout()
  }

  return (
    <SidebarMenu>
      <SidebarMenuItem>
        <DropdownMenu>
          <DropdownMenuTrigger asChild>
            <SidebarMenuButton
              size="lg"
              className="data-[state=open]:bg-sidebar-accent data-[state=open]:text-sidebar-accent-foreground"
              data-testid="user-menu"
            >
              <UserInfo fullName={user?.full_name} email={user?.email} avatarUrl={avatarUrl} />
              <ChevronsUpDown className="ml-auto size-4 text-muted-foreground" />
            </SidebarMenuButton>
          </DropdownMenuTrigger>
          <DropdownMenuContent
            className="w-(--radix-dropdown-menu-trigger-width) min-w-56 rounded-lg"
            side={isMobile ? "bottom" : "right"}
            align="end"
            sideOffset={4}
          >
            <DropdownMenuLabel className="p-0 font-normal">
              <UserInfo fullName={user?.full_name} email={user?.email} avatarUrl={avatarUrl} />
            </DropdownMenuLabel>
            <DropdownMenuSeparator />
            <RouterLink to="/settings" onClick={handleMenuClick}>
              <DropdownMenuItem>
                <Settings />
<<<<<<< HEAD
                {t("user.settings")}
=======
                User Settings
>>>>>>> a49a2d64878229f1071c2e2e32f0d609a5bf0113
              </DropdownMenuItem>
            </RouterLink>
            <DropdownMenuItem onClick={handleLogout}>
              <LogOut />
<<<<<<< HEAD
              {t("user.logout")}
=======
              Log Out
>>>>>>> a49a2d64878229f1071c2e2e32f0d609a5bf0113
            </DropdownMenuItem>
          </DropdownMenuContent>
        </DropdownMenu>
      </SidebarMenuItem>
    </SidebarMenu>
  )
}

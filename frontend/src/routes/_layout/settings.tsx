import { createFileRoute } from "@tanstack/react-router"
import { User, Key, AlertTriangle } from "lucide-react"

import ChangePassword from "@/components/UserSettings/ChangePassword"
import DeleteAccount from "@/components/UserSettings/DeleteAccount"
import UserInformation from "@/components/UserSettings/UserInformation"
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { Avatar, AvatarFallback } from "@/components/ui/avatar"
import useAuth from "@/hooks/useAuth"

const tabsConfig = [
  { 
    value: "my-profile", 
    title: "Hồ sơ của tôi", 
    icon: User,
    component: UserInformation 
  },
  { 
    value: "password", 
    title: "Mật khẩu", 
    icon: Key,
    component: ChangePassword 
  },
  { 
    value: "danger-zone", 
    title: "Vùng nguy hiểm", 
    icon: AlertTriangle,
    component: DeleteAccount 
  },
]

export const Route = createFileRoute("/_layout/settings")({
  component: UserSettings,
  head: () => ({
    meta: [
      {
        title: "Cài đặt - EduGuide VN",
      },
    ],
  }),
})

function UserSettings() {
  const { user: currentUser } = useAuth()
  const finalTabs = currentUser?.is_superuser
    ? tabsConfig.slice(0, 3)
    : tabsConfig

  if (!currentUser) {
    return null
  }

  const userInitials = currentUser.full_name
    ? currentUser.full_name
        .split(" ")
        .map((n) => n[0])
        .join("")
        .toUpperCase()
    : currentUser.email[0].toUpperCase()

  return (
    <div className="flex flex-col gap-8 max-w-5xl mx-auto py-4">
      <div className="flex flex-col gap-6 md:flex-row md:items-center md:justify-between px-2">
        <div className="flex items-center gap-5">
          <Avatar className="h-20 w-20 border-2 border-primary/20">
            <AvatarFallback className="text-2xl font-bold bg-primary/10 text-primary">
              {userInitials}
            </AvatarFallback>
          </Avatar>
          <div>
            <h1 className="text-3xl font-bold tracking-tight">Cài đặt tài khoản</h1>
            <p className="text-muted-foreground mt-1">
              Quản lý thông tin cá nhân và thiết lập bảo mật của bạn
            </p>
          </div>
        </div>
      </div>

      <Tabs defaultValue="my-profile" className="w-full">
        <TabsList className="mb-6 bg-muted/50 p-1">
          {finalTabs.map((tab) => (
            <TabsTrigger 
              key={tab.value} 
              value={tab.value}
              className="px-6 py-2 gap-2 data-[state=active]:bg-background data-[state=active]:shadow-sm transition-all"
            >
              <tab.icon className="h-4 w-4" />
              {tab.title}
            </TabsTrigger>
          ))}
        </TabsList>
        <div className="mt-2 animate-in fade-in slide-in-from-bottom-2 duration-300">
          {finalTabs.map((tab) => (
            <TabsContent key={tab.value} value={tab.value}>
              <tab.component />
            </TabsContent>
          ))}
        </div>
      </Tabs>
    </div>
  )
}

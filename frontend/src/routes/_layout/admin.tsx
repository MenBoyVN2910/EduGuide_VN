import { createFileRoute, Outlet, Link } from "@tanstack/react-router"
import { UsersService } from "@/client"
import { redirect } from "@tanstack/react-router"
import { useTranslation } from "react-i18next"

export const Route = createFileRoute("/_layout/admin")({
  component: AdminLayout,
  beforeLoad: async () => {
    const user = await UsersService.readUserMe()
    if (!user.is_superuser) {
      throw redirect({
        to: "/",
      })
    }
  },
  head: () => ({
    meta: [
      {
        title: "Admin Dashboard - EduGuide VN",
      },
    ],
  }),
})

function AdminLayout() {
  const { t } = useTranslation()

  return (
    <div className="flex h-full w-full">
      {/* Admin Sidebar */}
      <div className="w-64 border-r bg-muted/30 p-4 hidden md:block">
        <h2 className="text-lg font-semibold mb-6">{t("admin.panelTitle")}</h2>
        <nav className="flex flex-col gap-2">
          <Link
            to="/admin"
            activeProps={{ className: "bg-primary text-primary-foreground font-medium" }}
            activeOptions={{ exact: true }}
            className="p-2 rounded-md hover:bg-muted"
          >
            {t("admin.overview")}
          </Link>
          <Link
            to="/admin/users"
            activeProps={{ className: "bg-primary text-primary-foreground font-medium" }}
            className="p-2 rounded-md hover:bg-muted"
          >
            {t("admin.users")}
          </Link>
          <Link
            to="/admin/analytics"
            activeProps={{ className: "bg-primary text-primary-foreground font-medium" }}
            className="p-2 rounded-md hover:bg-muted"
          >
            {t("admin.analytics")}
          </Link>
          <Link
            to="/admin/knowledge"
            activeProps={{ className: "bg-primary text-primary-foreground font-medium" }}
            className="p-2 rounded-md hover:bg-muted"
          >
            {t("admin.knowledgeBase")}
          </Link>
        </nav>
      </div>

      {/* Admin Content */}
      <div className="flex-1 p-8 overflow-auto">
        <Outlet />
      </div>
    </div>
  )
}

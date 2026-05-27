import { useSuspenseQuery } from "@tanstack/react-query"
import { createFileRoute } from "@tanstack/react-router"
import { Suspense } from "react"
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table"
import { useTranslation } from "react-i18next"

import { AnalyticsService } from "@/client"

function getVisitsQueryOptions() {
  return {
    queryFn: () => AnalyticsService.getVisitEvents({ skip: 0, limit: 100 }),
    queryKey: ["visits"],
  }
}

export const Route = createFileRoute("/_layout/admin/analytics")({
  component: AdminAnalytics,
})

function VisitsTableContent() {
  const { data } = useSuspenseQuery(getVisitsQueryOptions())
  const { t } = useTranslation()

  return (
    <div className="rounded-md border">
      <Table>
        <TableHeader>
          <TableRow>
            <TableHead>{t("admin.path")}</TableHead>
            <TableHead>{t("admin.timestamp")}</TableHead>
            <TableHead>{t("admin.visitorId")}</TableHead>
          </TableRow>
        </TableHeader>
        <TableBody>
          {data.data.map((visit) => (
            <TableRow key={visit.id}>
              <TableCell className="font-medium">{visit.path}</TableCell>
              <TableCell>{new Date(visit.timestamp || "").toLocaleString()}</TableCell>
              <TableCell className="text-muted-foreground">{visit.visitor_id.substring(0, 8)}...</TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>
    </div>
  )
}

function AdminAnalytics() {
  const { t } = useTranslation()

  return (
    <div className="flex flex-col gap-6">
      <div>
        <h1 className="text-2xl font-bold tracking-tight">{t("admin.analytics")}</h1>
        <p className="text-muted-foreground">{t("admin.analyticsDesc")}</p>
      </div>
      <Suspense fallback={<div>{t("admin.loadingAnalytics")}</div>}>
        <VisitsTableContent />
      </Suspense>
    </div>
  )
}

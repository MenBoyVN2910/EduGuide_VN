import { useSuspenseQuery } from "@tanstack/react-query"
import { createFileRoute } from "@tanstack/react-router"
import { Suspense, useMemo } from "react"
import {
  AreaChart,
  Area,
  XAxis,
  YAxis,
  Tooltip,
  ResponsiveContainer,
  CartesianGrid,
} from "recharts"
import { useTranslation } from "react-i18next"
import { Users, Eye, BarChart3, TrendingUp } from "lucide-react"

import { AnalyticsService } from "@/client"

function getStatsQueryOptions() {
  return {
    queryFn: () => AnalyticsService.getAnalyticsStats(),
    queryKey: ["analytics-stats"],
  }
}

export const Route = createFileRoute("/_layout/admin/")({
  component: AdminOverview,
})

/**
 * Pad chart data to always show at least 7 days so the chart
 * never looks broken with only 1-2 data points.
 */
function usePaddedChartData(rawData: { date: string; visits: number }[]) {
  return useMemo(() => {
    const MIN_DAYS = 7
    if (!rawData || rawData.length === 0) {
      // Generate 7 empty days ending today
      const days: { date: string; visits: number }[] = []
      const today = new Date()
      for (let i = MIN_DAYS - 1; i >= 0; i--) {
        const d = new Date(today)
        d.setDate(d.getDate() - i)
        days.push({ date: d.toISOString().slice(0, 10), visits: 0 })
      }
      return days
    }

    if (rawData.length >= MIN_DAYS) return rawData

    // Build a map of existing data
    const dataMap = new Map(rawData.map((d) => [d.date, d.visits]))

    // Find the latest date in data
    const dates = rawData.map((d) => new Date(d.date).getTime())
    const latestDate = new Date(Math.max(...dates))

    // Pad backwards from latest date
    const result: { date: string; visits: number }[] = []
    for (let i = MIN_DAYS - 1; i >= 0; i--) {
      const d = new Date(latestDate)
      d.setDate(d.getDate() - i)
      const key = d.toISOString().slice(0, 10)
      result.push({ date: key, visits: dataMap.get(key) ?? 0 })
    }
    return result
  }, [rawData])
}

// Custom tooltip with dark theme styling
function ChartTooltip({ active, payload, label }: any) {
  const { t } = useTranslation()
  if (!active || !payload?.length) return null

  return (
    <div className="rounded-lg border bg-popover px-3 py-2 shadow-xl">
      <p className="text-xs text-muted-foreground mb-1">{label}</p>
      <p className="text-sm font-semibold">
        {payload[0].value} {t("admin.visitsChart").toLowerCase()}
      </p>
    </div>
  )
}

// Stat card icons & accent colors
const STAT_CARDS = [
  { key: "totalUsers", icon: Users, color: "from-blue-500/20 to-blue-600/5", iconColor: "text-blue-400", valueKey: "total_users" },
  { key: "totalVisitors", icon: Eye, color: "from-emerald-500/20 to-emerald-600/5", iconColor: "text-emerald-400", valueKey: "total_visitors" },
  { key: "totalPageViews", icon: BarChart3, color: "from-violet-500/20 to-violet-600/5", iconColor: "text-violet-400", valueKey: "total_visits" },
  { key: "viewsToday", icon: TrendingUp, color: "from-amber-500/20 to-amber-600/5", iconColor: "text-amber-400", valueKey: "visits_today" },
] as const

function DashboardContent() {
  const { data } = useSuspenseQuery(getStatsQueryOptions())
  const { t } = useTranslation()
  const chartData = usePaddedChartData(data.chart_data)

  return (
    <div className="flex flex-col gap-6">
      {/* Stat Cards */}
      <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-4">
        {STAT_CARDS.map(({ key, icon: Icon, color, iconColor, valueKey }) => (
          <div
            key={key}
            className={`rounded-xl border bg-gradient-to-br ${color} bg-card text-card-foreground shadow-sm transition-shadow hover:shadow-md`}
          >
            <div className="p-6 flex flex-row items-center justify-between pb-2">
              <h3 className="tracking-tight text-sm font-medium text-muted-foreground">
                {t(`admin.${key}`)}
              </h3>
              <Icon className={`h-4 w-4 ${iconColor}`} />
            </div>
            <div className="px-6 pb-6">
              <div className="text-3xl font-bold tabular-nums">
                {(data.stats as any)[valueKey]}
              </div>
            </div>
          </div>
        ))}
      </div>

      {/* Chart */}
      <div className="rounded-xl border bg-card text-card-foreground shadow-sm p-6">
        <h3 className="font-semibold leading-none tracking-tight mb-6">
          {t("admin.visitsChart")}
        </h3>
        <div className="h-[300px]">
          <ResponsiveContainer width="100%" height="100%">
            <AreaChart data={chartData} margin={{ top: 5, right: 10, left: -10, bottom: 0 }}>
              <defs>
                <linearGradient id="visitsGradient" x1="0" y1="0" x2="0" y2="1">
                  <stop offset="0%" stopColor="#60a5fa" stopOpacity={0.35} />
                  <stop offset="95%" stopColor="#60a5fa" stopOpacity={0.02} />
                </linearGradient>
              </defs>
              <CartesianGrid
                strokeDasharray="3 3"
                stroke="#374151"
                vertical={false}
              />
              <XAxis
                dataKey="date"
                stroke="#9ca3af"
                fontSize={12}
                tickLine={false}
                axisLine={false}
                tickFormatter={(value: string) => {
                  const d = new Date(value)
                  return `${d.getDate()}/${d.getMonth() + 1}`
                }}
              />
              <YAxis
                stroke="#9ca3af"
                fontSize={12}
                tickLine={false}
                axisLine={false}
                allowDecimals={false}
              />
              <Tooltip content={<ChartTooltip />} />
              <Area
                type="monotone"
                dataKey="visits"
                stroke="#60a5fa"
                strokeWidth={2.5}
                fill="url(#visitsGradient)"
                dot={{ r: 4, fill: "#60a5fa", strokeWidth: 2, stroke: "#1f2937" }}
                activeDot={{ r: 6, fill: "#60a5fa", strokeWidth: 2, stroke: "#1f2937" }}
              />
            </AreaChart>
          </ResponsiveContainer>
        </div>
      </div>
    </div>
  )
}

function AdminOverview() {
  const { t } = useTranslation()

  return (
    <div className="flex flex-col gap-6">
      <div>
        <h1 className="text-2xl font-bold tracking-tight">{t("admin.overview")}</h1>
        <p className="text-muted-foreground">{t("admin.summaryDesc")}</p>
      </div>
      <Suspense fallback={<div>{t("admin.loadingStats")}</div>}>
        <DashboardContent />
      </Suspense>
    </div>
  )
}

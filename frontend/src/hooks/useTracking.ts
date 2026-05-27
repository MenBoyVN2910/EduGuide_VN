import { useEffect } from "react"
import { useLocation } from "@tanstack/react-router"
import { AnalyticsService } from "@/client"

export function useTracking() {
  const location = useLocation()

  useEffect(() => {
    const trackPageview = async () => {
      try {
        await AnalyticsService.trackVisitor({
          path: location.pathname,
        })
      } catch (error) {
        console.error("Failed to track pageview", error)
      }
    }

    trackPageview()
  }, [location.pathname])
}

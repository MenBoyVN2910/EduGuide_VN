import { createFileRoute } from "@tanstack/react-router"

import ChatInterface from "@/components/Chat/ChatInterface"

export const Route = createFileRoute("/_layout/")({
  component: Dashboard,
  head: () => ({
    meta: [
      {
        title: "ChatBox AI Educational",
      },
    ],
  }),
})

function Dashboard() {
  return (
    <div className="flex h-full w-full overflow-hidden bg-background">
      <ChatInterface />
    </div>
  )
}

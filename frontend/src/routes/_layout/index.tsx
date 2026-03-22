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
  // Mở rộng div cha để ChatInterface có góc nhìn ChatGPT
  return (
    <div className="flex h-[calc(100vh-140px)] w-full overflow-hidden rounded-xl border bg-background shadow-sm">
      <ChatInterface />
    </div>
  )
}

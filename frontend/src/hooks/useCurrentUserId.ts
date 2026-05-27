import { useQuery } from "@tanstack/react-query"
import type { UserPublic } from "@/client"
import { UsersService } from "@/client"
import { isLoggedIn } from "./useAuth"

/**
 * Hook lấy User ID của người dùng hiện tại từ react-query cache.
 * Trả về userId (string) nếu đã đăng nhập, hoặc null nếu chưa.
 */
export function useCurrentUserId(): string | null {
  const { data: user } = useQuery<UserPublic | null, Error>({
    queryKey: ["currentUser"],
    queryFn: UsersService.readUserMe,
    enabled: isLoggedIn(),
  })
  return user?.id ?? null
}

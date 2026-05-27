import { useRef, useState, useEffect } from "react"
import { Camera, X } from "lucide-react"
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar"
import { cn } from "@/lib/utils"

// ─── localStorage Helper ──────────────────────────────────────────────────────

function getAvatarKey(userId: string) {
  return `avatar_${userId}`
}

export function loadAvatar(userId: string): string | null {
  try {
    return localStorage.getItem(getAvatarKey(userId))
  } catch {
    return null
  }
}

function saveAvatar(userId: string, dataUrl: string) {
  localStorage.setItem(getAvatarKey(userId), dataUrl)
}

function removeAvatar(userId: string) {
  localStorage.removeItem(getAvatarKey(userId))
}

// ─── Resize ảnh về kích thước tối đa để giảm dung lượng localStorage ────────

function resizeImage(file: File, maxSize: number = 256): Promise<string> {
  return new Promise((resolve, reject) => {
    const reader = new FileReader()
    reader.onload = (e) => {
      const img = new Image()
      img.onload = () => {
        const canvas = document.createElement("canvas")
        let { width, height } = img

        // Resize giữ tỉ lệ
        if (width > height) {
          if (width > maxSize) {
            height = Math.round((height * maxSize) / width)
            width = maxSize
          }
        } else {
          if (height > maxSize) {
            width = Math.round((width * maxSize) / height)
            height = maxSize
          }
        }

        canvas.width = width
        canvas.height = height
        const ctx = canvas.getContext("2d")
        if (!ctx) return reject(new Error("Canvas not supported"))

        ctx.drawImage(img, 0, 0, width, height)
        resolve(canvas.toDataURL("image/webp", 0.85))
      }
      img.onerror = reject
      img.src = e.target?.result as string
    }
    reader.onerror = reject
    reader.readAsDataURL(file)
  })
}

// ─── Component ────────────────────────────────────────────────────────────────

interface AvatarUploadProps {
  userId: string
  initials: string
  size?: "sm" | "lg"
  className?: string
}

export function AvatarUpload({ userId, initials, size = "lg", className }: AvatarUploadProps) {
  const [avatarUrl, setAvatarUrl] = useState<string | null>(() => loadAvatar(userId))
  const fileInputRef = useRef<HTMLInputElement>(null)

  // Khi userId thay đổi, load avatar mới
  useEffect(() => {
    setAvatarUrl(loadAvatar(userId))
  }, [userId])

  const handleFileSelect = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0]
    if (!file) return

    // Kiểm tra loại file
    if (!file.type.startsWith("image/")) {
      alert("Vui lòng chọn file ảnh (JPG, PNG, WebP, ...)")
      return
    }

    // Kiểm tra dung lượng (max 5MB trước resize)
    if (file.size > 5 * 1024 * 1024) {
      alert("Ảnh quá lớn. Vui lòng chọn ảnh nhỏ hơn 5MB.")
      return
    }

    try {
      const dataUrl = await resizeImage(file, 256)
      saveAvatar(userId, dataUrl)
      setAvatarUrl(dataUrl)
    } catch {
      alert("Không thể xử lý ảnh. Vui lòng thử ảnh khác.")
    }

    // Reset input để có thể chọn lại cùng file
    e.target.value = ""
  }

  const handleRemove = (e: React.MouseEvent) => {
    e.stopPropagation()
    removeAvatar(userId)
    setAvatarUrl(null)
  }

  const isLarge = size === "lg"

  return (
    <div className={cn("relative group", className)}>
      <Avatar
        className={cn(
          "cursor-pointer transition-all duration-200",
          isLarge
            ? "h-20 w-20 border-2 border-primary/20 hover:border-primary/40"
            : "size-8",
        )}
        onClick={() => fileInputRef.current?.click()}
      >
        {avatarUrl && (
          <AvatarImage src={avatarUrl} alt="Avatar" className="object-cover" />
        )}
        <AvatarFallback
          className={cn(
            isLarge
              ? "text-2xl font-bold bg-primary/10 text-primary"
              : "bg-zinc-600 text-white text-xs",
          )}
        >
          {initials}
        </AvatarFallback>
      </Avatar>

      {/* Overlay khi hover (chỉ cho size lớn) */}
      {isLarge && (
        <div
          className="absolute inset-0 flex items-center justify-center rounded-full bg-black/50 opacity-0 group-hover:opacity-100 transition-opacity cursor-pointer"
          onClick={() => fileInputRef.current?.click()}
        >
          <Camera className="h-6 w-6 text-white" />
        </div>
      )}

      {/* Nút xóa avatar */}
      {avatarUrl && isLarge && (
        <button
          type="button"
          onClick={handleRemove}
          className="absolute -top-1 -right-1 h-6 w-6 rounded-full bg-destructive text-destructive-foreground flex items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity shadow-md hover:scale-110"
          title="Xóa ảnh đại diện"
        >
          <X className="h-3.5 w-3.5" />
        </button>
      )}

      <input
        ref={fileInputRef}
        type="file"
        accept="image/*"
        onChange={handleFileSelect}
        className="hidden"
      />
    </div>
  )
}

export default AvatarUpload

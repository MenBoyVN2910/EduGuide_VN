interface LogoProps {
  onClick?: () => void
}

export const Logo = ({ onClick }: LogoProps) => {
  return (
    <div
      className="flex items-center gap-3 transition-all hover:opacity-90 overflow-hidden cursor-pointer select-none"
      onClick={onClick}
      role="button"
      tabIndex={0}
      onKeyDown={(e) => { if (e.key === "Enter" || e.key === " ") onClick?.() }}
      title="Tạo cuộc trò chuyện mới"
    >
      {/* Logo icon — giữ cố định, không bị thu nhỏ */}
      <img
        src="/assets/images/eduguide-logo.png"
        alt="EduGuide VN Logo"
        className="h-10 w-10 shrink-0 object-contain drop-shadow-md bg-white rounded-lg p-1"
        onError={(e) => {
          e.currentTarget.style.display = 'none'
        }}
      />

      {/* Text — ẩn khi sidebar ở icon mode */}
      <div className="flex flex-col group-data-[collapsible=icon]:hidden">
        <span className="text-xl font-bold tracking-tight bg-linear-to-r from-blue-600 to-teal-500 bg-clip-text text-transparent dark:from-blue-400 dark:to-teal-300">
          EduGuide
        </span>
        <span className="text-[10px] font-semibold tracking-widest text-slate-500 dark:text-slate-400 uppercase -mt-1">
          Vietnam
        </span>
      </div>
    </div>
  )
}

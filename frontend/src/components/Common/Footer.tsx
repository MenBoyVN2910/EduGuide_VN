import { FaFacebook, FaGithub, FaYoutube } from "react-icons/fa6"

const socialLinks = [
  { icon: FaGithub, href: "https://github.com", label: "GitHub" },
  { icon: FaFacebook, href: "https://facebook.com", label: "Facebook" },
  {
    icon: FaYoutube,
    href: "https://youtube.com",
    label: "YouTube",
  },
]

export function Footer() {
  const currentYear = new Date().getFullYear()

  return (
    <footer className="w-full border-t border-slate-200 dark:border-slate-800 bg-white/50 dark:bg-card/50 backdrop-blur-sm mt-auto">
      <div className="max-w-7xl mx-auto px-4 flex flex-col items-center justify-between gap-4 py-8 sm:flex-row sm:gap-6">
        <div className="flex gap-4">
          {socialLinks.map((link) => {
            const Icon = link.icon
            return (
              <a
                key={link.label}
                href={link.href}
                target="_blank"
                rel="noopener noreferrer"
                className="text-slate-500 hover:text-blue-600 dark:text-slate-400 dark:hover:text-blue-400 transition-colors"
                aria-label={link.label}
              >
                <Icon className="h-6 w-6" />
              </a>
            )
          })}
        </div>
        <p className="text-sm text-slate-500 dark:text-slate-400">
          EduGuide VN Educational System - {currentYear}
        </p>
      </div>
    </footer>
  )
}

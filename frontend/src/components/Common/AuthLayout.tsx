import { Appearance } from "@/components/Common/Appearance"
import { Logo } from "@/components/Common/Logo"

interface AuthLayoutProps {
  children: React.ReactNode
}

export function AuthLayout({ children }: AuthLayoutProps) {
  return (
    <div className="relative flex min-h-screen flex-col items-center justify-center bg-gradient-to-br from-blue-50 via-white to-teal-50 dark:from-slate-950 dark:via-background dark:to-slate-900 px-4 py-8 overflow-hidden z-0">
      
      {/* Decorative Background Elements */}
      <div className="absolute top-0 left-0 w-full h-full overflow-hidden -z-10 pointer-events-none">
        <div className="absolute top-[-10%] left-[-10%] w-[50%] h-[50%] rounded-full bg-blue-400/10 dark:bg-blue-600/10 blur-[100px]" />
        <div className="absolute bottom-[-10%] right-[-10%] w-[50%] h-[50%] rounded-full bg-teal-400/10 dark:bg-teal-600/10 blur-[100px]" />
      </div>

      <div className="absolute top-4 right-4 md:top-8 md:right-8 z-20">
        <Appearance />
      </div>
      
      <div className="w-full max-w-md relative z-10 flex flex-col items-center">
        <div className="flex justify-center mb-8 transform hover:scale-105 transition-transform duration-300">
          <Logo />
        </div>
        
        <div className="w-full bg-white/80 dark:bg-card/80 backdrop-blur-2xl border border-white/40 dark:border-border/50 shadow-2xl rounded-3xl p-8 md:p-10 relative overflow-hidden">
          {children}
        </div>
        
        <div className="mt-8 text-center text-sm text-slate-500 dark:text-slate-400">
          &copy; {new Date().getFullYear()} EduGuide VN. All rights reserved.
        </div>
      </div>
    </div>
  )
}

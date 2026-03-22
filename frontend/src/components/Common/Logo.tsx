import { GraduationCap } from "lucide-react"

export const Logo = (props: any) => {
  return (
    <div className="flex items-center gap-3 transition-all hover:opacity-90">
      <img 
        src="/assets/images/eduguide-logo.png" 
        alt="EduGuide VN Logo" 
        className="h-10 w-10 object-contain drop-shadow-md bg-white rounded-lg p-1"
        onError={(e) => {
          e.currentTarget.style.display = 'none';
          const sibling = e.currentTarget.nextElementSibling as HTMLElement;
          if (sibling) sibling.style.display = 'flex';
        }}
      />
      <div className="hidden h-10 w-10 items-center justify-center rounded-lg bg-gradient-to-tr from-blue-600 to-teal-500 shadow-md">
        <GraduationCap className="h-6 w-6 text-white" />
      </div>
      
      <div className="flex flex-col">
        <span className="text-xl font-bold tracking-tight bg-gradient-to-r from-blue-600 to-teal-500 bg-clip-text text-transparent dark:from-blue-400 dark:to-teal-300">
          EduGuide
        </span>
        <span className="text-[10px] font-semibold tracking-widest text-slate-500 dark:text-slate-400 uppercase -mt-1">
          Vietnam
        </span>
      </div>
    </div>
  )
}

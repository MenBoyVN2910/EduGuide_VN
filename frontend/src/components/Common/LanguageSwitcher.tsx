import { useTranslation } from "react-i18next"
import { Languages } from "lucide-react"
import { Button } from "@/components/ui/button"
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu"
import {
  SidebarMenuButton,
  SidebarMenuItem,
  useSidebar,
} from "@/components/ui/sidebar"

const LANGUAGES = [
  { code: "en", flag: "🇬🇧" },
  { code: "vi", flag: "🇻🇳" },
] as const

export const SidebarLanguageSwitcher = () => {
  const { isMobile } = useSidebar()
  const { t, i18n } = useTranslation()
  const currentLang = i18n.language

  const handleChange = (langCode: string) => {
    i18n.changeLanguage(langCode)
  }

  return (
    <SidebarMenuItem>
      <DropdownMenu modal={false}>
        <DropdownMenuTrigger asChild>
          <SidebarMenuButton tooltip={t(`language.label`)} data-testid="language-switcher">
            <Languages className="size-4 text-muted-foreground" />
            <span>{t(`language.${currentLang}`)}</span>
          </SidebarMenuButton>
        </DropdownMenuTrigger>
        <DropdownMenuContent
          side={isMobile ? "top" : "right"}
          align="end"
          className="w-(--radix-dropdown-menu-trigger-width) min-w-56"
        >
          {LANGUAGES.map((lang) => (
            <DropdownMenuItem
              key={lang.code}
              onClick={() => handleChange(lang.code)}
              className={currentLang === lang.code ? "bg-accent font-medium" : ""}
              data-testid={`lang-${lang.code}`}
            >
              <span className="mr-2">{lang.flag}</span>
              {t(`language.${lang.code}`)}
            </DropdownMenuItem>
          ))}
        </DropdownMenuContent>
      </DropdownMenu>
    </SidebarMenuItem>
  )
}

export const LanguageSwitcher = () => {
  const { t, i18n } = useTranslation()
  const currentLang = i18n.language

  const handleChange = (langCode: string) => {
    i18n.changeLanguage(langCode)
  }

  return (
    <DropdownMenu modal={false}>
      <DropdownMenuTrigger asChild>
        <Button
          variant="outline"
          size="sm"
          className="gap-2"
          data-testid="language-switcher"
        >
          <Languages className="h-4 w-4" />
          <span className="hidden sm:inline">
            {t(`language.${currentLang}`)}
          </span>
        </Button>
      </DropdownMenuTrigger>
      <DropdownMenuContent align="end">
        {LANGUAGES.map((lang) => (
          <DropdownMenuItem
            key={lang.code}
            onClick={() => handleChange(lang.code)}
            className={currentLang === lang.code ? "bg-accent font-medium" : ""}
            data-testid={`lang-${lang.code}`}
          >
            <span className="mr-2">{lang.flag}</span>
            {t(`language.${lang.code}`)}
          </DropdownMenuItem>
        ))}
      </DropdownMenuContent>
    </DropdownMenu>
  )
}

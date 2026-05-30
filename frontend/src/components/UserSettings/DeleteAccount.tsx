import { AlertTriangle } from "lucide-react"
import { useTranslation } from "react-i18next"

import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card"
import DeleteConfirmation from "./DeleteConfirmation"

const DeleteAccount = () => {
  const { t } = useTranslation()
  return (
    <Card className="max-w-2xl border-destructive/20 bg-destructive/5 dark:bg-destructive/10">
      <CardHeader>
        <CardTitle className="text-xl flex items-center gap-2 text-destructive">
          <AlertTriangle className="h-5 w-5" />
          {t("settings.delAccTitle")}
        </CardTitle>
        <CardDescription className="text-destructive/80 font-medium">
          {t("settings.delAccSubtitle")}
        </CardDescription>
      </CardHeader>
      <CardContent>
        <p className="text-sm text-muted-foreground mb-6">
          {t("settings.delAccWarning")}
        </p>
        <DeleteConfirmation />
      </CardContent>
    </Card>
  )
}

export default DeleteAccount

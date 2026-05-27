import { AlertTriangle } from "lucide-react"
<<<<<<< HEAD
import { useTranslation } from "react-i18next"
=======
>>>>>>> a49a2d64878229f1071c2e2e32f0d609a5bf0113

import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card"
import DeleteConfirmation from "./DeleteConfirmation"

const DeleteAccount = () => {
<<<<<<< HEAD
  const { t } = useTranslation()
=======
>>>>>>> a49a2d64878229f1071c2e2e32f0d609a5bf0113
  return (
    <Card className="max-w-2xl border-destructive/20 bg-destructive/5 dark:bg-destructive/10">
      <CardHeader>
        <CardTitle className="text-xl flex items-center gap-2 text-destructive">
          <AlertTriangle className="h-5 w-5" />
<<<<<<< HEAD
          {t("settings.delAccTitle")}
        </CardTitle>
        <CardDescription className="text-destructive/80 font-medium">
          {t("settings.delAccSubtitle")}
=======
          Xóa tài khoản
        </CardTitle>
        <CardDescription className="text-destructive/80 font-medium">
          Dữ liệu của bạn sẽ bị xóa vĩnh viễn và không thể khôi phục.
>>>>>>> a49a2d64878229f1071c2e2e32f0d609a5bf0113
        </CardDescription>
      </CardHeader>
      <CardContent>
        <p className="text-sm text-muted-foreground mb-6">
<<<<<<< HEAD
          {t("settings.delAccWarning")}
=======
          Khi bạn xóa tài khoản, tất cả các ghi chú, lịch sử trò chuyện và thông tin cá nhân của bạn sẽ bị xóa khỏi hệ thống của chúng tôi. Hành động này là không thể hoàn tác.
>>>>>>> a49a2d64878229f1071c2e2e32f0d609a5bf0113
        </p>
        <DeleteConfirmation />
      </CardContent>
    </Card>
  )
}

export default DeleteAccount

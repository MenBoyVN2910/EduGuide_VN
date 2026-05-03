import { zodResolver } from "@hookform/resolvers/zod"
import { useMutation } from "@tanstack/react-query"
import { useState } from "react"
import { useForm } from "react-hook-form"
import { z } from "zod"
import { Key, Lock, ShieldCheck, CheckCircle2 } from "lucide-react"

import { type UpdatePassword, UsersService, LoginService } from "@/client"
import {
  Form,
  FormControl,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "@/components/ui/form"
import { LoadingButton } from "@/components/ui/loading-button"
import { PasswordInput } from "@/components/ui/password-input"
import { Button } from "@/components/ui/button"
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card"
import useAuth from "@/hooks/useAuth"
import useCustomToast from "@/hooks/useCustomToast"
import { handleError } from "@/utils"

// ─── Step 1: Xác minh mật khẩu hiện tại ──────────────────────────────────────

const verifySchema = z.object({
  current_password: z
    .string()
    .min(1, { message: "Mật khẩu hiện tại là bắt buộc" })
    .min(8, { message: "Mật khẩu phải có ít nhất 8 ký tự" }),
})

type VerifyFormData = z.infer<typeof verifySchema>

// ─── Step 2: Đặt mật khẩu mới ────────────────────────────────────────────────

const changeSchema = z
  .object({
    new_password: z
      .string()
      .min(1, { message: "Mật khẩu mới là bắt buộc" })
      .min(8, { message: "Mật khẩu mới phải có ít nhất 8 ký tự" }),
    confirm_password: z
      .string()
      .min(1, { message: "Xác nhận mật khẩu là bắt buộc" }),
  })
  .refine((data) => data.new_password === data.confirm_password, {
    message: "Mật khẩu xác nhận không khớp",
    path: ["confirm_password"],
  })

type ChangeFormData = z.infer<typeof changeSchema>

// ─── Component ────────────────────────────────────────────────────────────────

const ChangePassword = () => {
  const { showSuccessToast, showErrorToast } = useCustomToast()
  const { user: currentUser } = useAuth()

  // State 2-step flow
  const [isVerified, setIsVerified] = useState(false)
  const [verifiedPassword, setVerifiedPassword] = useState("")

  // ── Step 1: Form xác minh ─────────────────────────────────────────

  const verifyForm = useForm<VerifyFormData>({
    resolver: zodResolver(verifySchema),
    mode: "onSubmit",
    defaultValues: { current_password: "" },
  })

  const verifyMutation = useMutation({
    mutationFn: async (data: VerifyFormData) => {
      // Dùng API login để xác minh mật khẩu hiện tại
      await LoginService.loginAccessToken({
        formData: {
          username: currentUser?.email || "",
          password: data.current_password,
        },
      })
    },
    onSuccess: () => {
      setVerifiedPassword(verifyForm.getValues("current_password"))
      setIsVerified(true)
    },
    onError: () => {
      showErrorToast("Mật khẩu hiện tại không đúng. Vui lòng thử lại.")
      verifyForm.setError("current_password", {
        message: "Mật khẩu không đúng",
      })
    },
  })

  const onVerify = (data: VerifyFormData) => {
    verifyMutation.mutate(data)
  }

  // ── Step 2: Form đổi mật khẩu ─────────────────────────────────────

  const changeForm = useForm<ChangeFormData>({
    resolver: zodResolver(changeSchema),
    mode: "onSubmit",
    defaultValues: { new_password: "", confirm_password: "" },
  })

  const changeMutation = useMutation({
    mutationFn: (data: UpdatePassword) =>
      UsersService.updatePasswordMe({ requestBody: data }),
    onSuccess: () => {
      showSuccessToast("Cập nhật mật khẩu thành công")
      changeForm.reset()
      // Reset về Step 1 cho lần đổi tiếp theo
      setIsVerified(false)
      setVerifiedPassword("")
      verifyForm.reset()
    },
    onError: handleError.bind(showErrorToast),
  })

  const onChange = (data: ChangeFormData) => {
    changeMutation.mutate({
      current_password: verifiedPassword,
      new_password: data.new_password,
    })
  }

  // ── Reset về Step 1 ────────────────────────────────────────────────

  const handleBack = () => {
    setIsVerified(false)
    setVerifiedPassword("")
    verifyForm.reset()
    changeForm.reset()
  }

  return (
    <Card className="max-w-2xl border-none shadow-none bg-transparent md:bg-card md:border md:shadow-sm">
      <CardHeader>
        <CardTitle className="text-xl flex items-center gap-2">
          <Key className="h-5 w-5 text-primary" />
          Đổi mật khẩu
        </CardTitle>
        <CardDescription>
          {isVerified
            ? "Xác minh thành công! Bây giờ bạn có thể đặt mật khẩu mới."
            : "Vui lòng xác minh mật khẩu hiện tại trước khi đổi mật khẩu mới."
          }
        </CardDescription>
      </CardHeader>
      <CardContent>
        {!isVerified ? (
          /* ── Step 1: Xác minh mật khẩu hiện tại ── */
          <Form {...verifyForm}>
            <form
              onSubmit={verifyForm.handleSubmit(onVerify)}
              className="grid gap-6"
            >
              <FormField
                control={verifyForm.control}
                name="current_password"
                render={({ field, fieldState }) => (
                  <FormItem>
                    <FormLabel className="flex items-center gap-2">
                      <Lock className="h-4 w-4 text-muted-foreground" />
                      Mật khẩu hiện tại
                    </FormLabel>
                    <FormControl>
                      <PasswordInput
                        data-testid="current-password-input"
                        placeholder="Nhập mật khẩu hiện tại để xác minh..."
                        aria-invalid={fieldState.invalid}
                        className="bg-muted/30 focus-visible:bg-background transition-colors"
                        {...field}
                      />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />

              <div className="pt-2">
                <LoadingButton
                  type="submit"
                  loading={verifyMutation.isPending}
                  className="px-8"
                >
                  <ShieldCheck className="h-4 w-4 mr-2" />
                  Xác minh mật khẩu
                </LoadingButton>
              </div>
            </form>
          </Form>
        ) : (
          /* ── Step 2: Đặt mật khẩu mới ── */
          <div className="space-y-6">
            {/* Badge xác minh thành công */}
            <div className="flex items-center gap-2 text-sm text-emerald-600 dark:text-emerald-400 bg-emerald-500/10 px-4 py-2.5 rounded-xl border border-emerald-500/20">
              <CheckCircle2 className="h-4 w-4 shrink-0" />
              <span className="font-medium">Mật khẩu đã được xác minh thành công</span>
            </div>

            <Form {...changeForm}>
              <form
                onSubmit={changeForm.handleSubmit(onChange)}
                className="grid gap-6"
              >
                <FormField
                  control={changeForm.control}
                  name="new_password"
                  render={({ field, fieldState }) => (
                    <FormItem>
                      <FormLabel className="flex items-center gap-2">
                        <ShieldCheck className="h-4 w-4 text-muted-foreground" />
                        Mật khẩu mới
                      </FormLabel>
                      <FormControl>
                        <PasswordInput
                          data-testid="new-password-input"
                          placeholder="••••••••"
                          aria-invalid={fieldState.invalid}
                          className="bg-muted/30 focus-visible:bg-background transition-colors"
                          {...field}
                        />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />

                <FormField
                  control={changeForm.control}
                  name="confirm_password"
                  render={({ field, fieldState }) => (
                    <FormItem>
                      <FormLabel className="flex items-center gap-2">
                        <Lock className="h-4 w-4 text-muted-foreground" />
                        Xác nhận mật khẩu mới
                      </FormLabel>
                      <FormControl>
                        <PasswordInput
                          data-testid="confirm-password-input"
                          placeholder="••••••••"
                          aria-invalid={fieldState.invalid}
                          className="bg-muted/30 focus-visible:bg-background transition-colors"
                          {...field}
                        />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />

                <div className="flex items-center gap-3 pt-2">
                  <LoadingButton
                    type="submit"
                    loading={changeMutation.isPending}
                    className="px-8"
                  >
                    Cập nhật mật khẩu
                  </LoadingButton>
                  <Button
                    type="button"
                    variant="outline"
                    onClick={handleBack}
                    disabled={changeMutation.isPending}
                  >
                    Quay lại
                  </Button>
                </div>
              </form>
            </Form>
          </div>
        )}
      </CardContent>
    </Card>
  )
}

export default ChangePassword

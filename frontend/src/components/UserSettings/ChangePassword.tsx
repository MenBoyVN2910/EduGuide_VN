import { zodResolver } from "@hookform/resolvers/zod"
import { useMutation } from "@tanstack/react-query"
import { useForm } from "react-hook-form"
import { z } from "zod"
import { Key, Lock, ShieldCheck } from "lucide-react"

import { type UpdatePassword, UsersService } from "@/client"
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
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card"
import useCustomToast from "@/hooks/useCustomToast"
import { handleError } from "@/utils"

const formSchema = z
  .object({
    current_password: z
      .string()
      .min(1, { message: "Mật khẩu hiện tại là bắt buộc" })
      .min(8, { message: "Mật khẩu phải có ít nhất 8 ký tự" }),
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

type FormData = z.infer<typeof formSchema>

const ChangePassword = () => {
  const { showSuccessToast, showErrorToast } = useCustomToast()
  const form = useForm<FormData>({
    resolver: zodResolver(formSchema),
    mode: "onSubmit",
    criteriaMode: "all",
    defaultValues: {
      current_password: "",
      new_password: "",
      confirm_password: "",
    },
  })

  const mutation = useMutation({
    mutationFn: (data: UpdatePassword) =>
      UsersService.updatePasswordMe({ requestBody: data }),
    onSuccess: () => {
      showSuccessToast("Cập nhật mật khẩu thành công")
      form.reset()
    },
    onError: handleError.bind(showErrorToast),
  })

  const onSubmit = async (data: FormData) => {
    mutation.mutate(data)
  }

  return (
    <Card className="max-w-2xl border-none shadow-none bg-transparent md:bg-card md:border md:shadow-sm">
      <CardHeader>
        <CardTitle className="text-xl flex items-center gap-2">
          <Key className="h-5 w-5 text-primary" />
          Đổi mật khẩu
        </CardTitle>
        <CardDescription>
          Đảm bảo mật khẩu của bạn có ít nhất 8 ký tự để bảo mật tối ưu.
        </CardDescription>
      </CardHeader>
      <CardContent>
        <Form {...form}>
          <form
            onSubmit={form.handleSubmit(onSubmit)}
            className="grid gap-6"
          >
            <FormField
              control={form.control}
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
              control={form.control}
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
              control={form.control}
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

            <div className="pt-2">
              <LoadingButton
                type="submit"
                loading={mutation.isPending}
                className="px-8"
              >
                Cập nhật mật khẩu
              </LoadingButton>
            </div>
          </form>
        </Form>
      </CardContent>
    </Card>
  )
}

export default ChangePassword

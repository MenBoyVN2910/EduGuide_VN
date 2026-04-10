import { zodResolver } from "@hookform/resolvers/zod"
import { useMutation, useQueryClient } from "@tanstack/react-query"
import { useState } from "react"
import { useForm } from "react-hook-form"
import { z } from "zod"
import { User, Mail } from "lucide-react"

import { UsersService, type UserUpdateMe } from "@/client"
import { Button } from "@/components/ui/button"
import {
  Form,
  FormControl,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "@/components/ui/form"
import { Input } from "@/components/ui/input"
import { LoadingButton } from "@/components/ui/loading-button"
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card"
import useAuth from "@/hooks/useAuth"
import useCustomToast from "@/hooks/useCustomToast"
import { cn } from "@/lib/utils"
import { handleError } from "@/utils"

const formSchema = z.object({
  full_name: z.string().max(30).optional(),
  email: z.string().email({ message: "Địa chỉ email không hợp lệ" }),
})

type FormData = z.infer<typeof formSchema>

const UserInformation = () => {
  const queryClient = useQueryClient()
  const { showSuccessToast, showErrorToast } = useCustomToast()
  const [editMode, setEditMode] = useState(false)
  const { user: currentUser } = useAuth()

  const form = useForm<FormData>({
    resolver: zodResolver(formSchema),
    mode: "onBlur",
    criteriaMode: "all",
    defaultValues: {
      full_name: currentUser?.full_name ?? undefined,
      email: currentUser?.email,
    },
  })

  const toggleEditMode = () => {
    setEditMode(!editMode)
  }

  const mutation = useMutation({
    mutationFn: (data: UserUpdateMe) =>
      UsersService.updateUserMe({ requestBody: data }),
    onSuccess: () => {
      showSuccessToast("Cập nhật thông tin thành công")
      toggleEditMode()
    },
    onError: handleError.bind(showErrorToast),
    onSettled: () => {
      queryClient.invalidateQueries()
    },
  })

  const onSubmit = (data: FormData) => {
    const updateData: UserUpdateMe = {}

    // chỉ bao gồm các trường đã thay đổi
    if (data.full_name !== currentUser?.full_name) {
      updateData.full_name = data.full_name
    }
    if (data.email !== currentUser?.email) {
      updateData.email = data.email
    }

    mutation.mutate(updateData)
  }

  const onCancel = () => {
    form.reset()
    toggleEditMode()
  }

  return (
    <Card className="max-w-2xl border-none shadow-none bg-transparent md:bg-card md:border md:shadow-sm">
      <CardHeader>
        <CardTitle className="text-xl flex items-center gap-2">
          <User className="h-5 w-5 text-primary" />
          Thông tin cá nhân
        </CardTitle>
        <CardDescription>
          Cập nhật thông tin cơ bản của bạn tại đây.
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
              name="full_name"
              render={({ field }) => (
                <FormItem>
                  <FormLabel className="flex items-center gap-2">
                    <User className="h-4 w-4 text-muted-foreground" />
                    Họ và tên
                  </FormLabel>
                  {editMode ? (
                    <FormControl>
                      <Input 
                        type="text" 
                        {...field} 
                        className="bg-muted/30 focus-visible:bg-background transition-colors"
                      />
                    </FormControl>
                  ) : (
                    <div className="p-3 rounded-lg bg-muted/20 border border-transparent">
                      <p
                        className={cn(
                          "truncate font-medium",
                          !field.value && "text-muted-foreground",
                        )}
                      >
                        {field.value || "Chưa cập nhật"}
                      </p>
                    </div>
                  )}
                  <FormMessage />
                </FormItem>
              )}
            />

            <FormField
              control={form.control}
              name="email"
              render={({ field }) => (
                <FormItem>
                  <FormLabel className="flex items-center gap-2">
                    <Mail className="h-4 w-4 text-muted-foreground" />
                    Địa chỉ Email
                  </FormLabel>
                  {editMode ? (
                    <FormControl>
                      <Input 
                        type="email" 
                        {...field} 
                        className="bg-muted/30 focus-visible:bg-background transition-colors"
                      />
                    </FormControl>
                  ) : (
                    <div className="p-3 rounded-lg bg-muted/20 border border-transparent">
                      <p className="truncate font-medium">{field.value}</p>
                    </div>
                  )}
                  <FormMessage />
                </FormItem>
              )}
            />

            <div className="flex items-center gap-3 pt-2">
              {editMode ? (
                <>
                  <LoadingButton
                    type="submit"
                    loading={mutation.isPending}
                    disabled={!form.formState.isDirty}
                  >
                    Lưu thay đổi
                  </LoadingButton>
                  <Button
                    type="button"
                    variant="outline"
                    onClick={onCancel}
                    disabled={mutation.isPending}
                  >
                    Hủy bỏ
                  </Button>
                </>
              ) : (
                <Button 
                  type="button" 
                  onClick={toggleEditMode}
                  className="px-8"
                >
                  Chỉnh sửa
                </Button>
              )}
            </div>
          </form>
        </Form>
      </CardContent>
    </Card>
  )
}

export default UserInformation

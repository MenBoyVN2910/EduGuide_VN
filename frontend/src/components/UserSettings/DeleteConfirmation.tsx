import { useMutation, useQueryClient } from "@tanstack/react-query"
import { useForm } from "react-hook-form"
import { AlertCircle, Trash2 } from "lucide-react"

import { UsersService } from "@/client"
import { Button } from "@/components/ui/button"
import {
  Dialog,
  DialogClose,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog"
import { LoadingButton } from "@/components/ui/loading-button"
import useAuth from "@/hooks/useAuth"
import useCustomToast from "@/hooks/useCustomToast"
import { handleError } from "@/utils"

const DeleteConfirmation = () => {
  const queryClient = useQueryClient()
  const { showSuccessToast, showErrorToast } = useCustomToast()
  const { handleSubmit } = useForm()
  const { logout } = useAuth()

  const mutation = useMutation({
    mutationFn: () => UsersService.deleteUserMe(),
    onSuccess: () => {
      showSuccessToast("Tài khoản của bạn đã được xóa thành công")
      logout()
    },
    onError: handleError.bind(showErrorToast),
    onSettled: () => {
      queryClient.invalidateQueries({ queryKey: ["currentUser"] })
    },
  })

  const onSubmit = async () => {
    mutation.mutate()
  }

  return (
    <Dialog>
      <DialogTrigger asChild>
        <Button variant="destructive" className="mt-3 gap-2">
          <Trash2 className="h-4 w-4" />
          Xác nhận xóa tài khoản
        </Button>
      </DialogTrigger>
      <DialogContent>
        <form onSubmit={handleSubmit(onSubmit)}>
          <DialogHeader>
            <DialogTitle className="flex items-center gap-2 text-destructive">
              <AlertCircle className="h-5 w-5" />
              Yêu cầu xác nhận
            </DialogTitle>
            <DialogDescription className="pt-2">
              Tất cả dữ liệu tài khoản của bạn sẽ bị{" "}
              <strong className="text-foreground">xóa vĩnh viễn.</strong> Nếu bạn chắc chắn, hãy nhấn
              nhấn <strong>"Xác nhận xóa"</strong> để tiếp tục. Hành động này
              không thể khôi phục.
            </DialogDescription>
          </DialogHeader>

          <DialogFooter className="mt-6 gap-3 sm:gap-0">
            <DialogClose asChild>
              <Button variant="outline" disabled={mutation.isPending}>
                Hủy bỏ
              </Button>
            </DialogClose>
            <LoadingButton
              variant="destructive"
              type="submit"
              loading={mutation.isPending}
              className="gap-2"
            >
              <Trash2 className="h-4 w-4" />
              Xác nhận xóa
            </LoadingButton>
          </DialogFooter>
        </form>
      </DialogContent>
    </Dialog>
  )
}

export default DeleteConfirmation

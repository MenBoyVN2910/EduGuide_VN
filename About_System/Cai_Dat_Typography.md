# Cài đặt @tailwindcss/typography

Để cài đặt plugin typography cho Tailwind CSS trong dự án của bạn (đang sử dụng Bun), hãy làm theo các bước sau:

## 1. Cài đặt package
Mở terminal tại thư mục `frontend` và chạy lệnh sau:

```bash
bun add @tailwindcss/typography
```

## 2. Cấu hình CSS
Vì bạn đang sử dụng **Tailwind CSS v4**, bạn cần thêm plugin vào file CSS chính của mình (thường là `src/index.css`).

Trong file `frontend/src/index.css`, hãy thêm dòng sau vào đầu file:

```css
@import "tailwindcss";
@plugin "@tailwindcss/typography";
```

*(Lưu ý: Qua kiểm tra, tôi thấy file `index.css` của bạn đã có dòng này rồi, bạn chỉ cần thực hiện bước 1 để package được cài đặt chính thức vào `package.json` thôi).*

## 3. Cách sử dụng
Sau khi cài đặt, bạn có thể sử dụng class `prose` để định dạng nội dung (ví dụ: nội dung từ Markdown):

```html
<div class="prose dark:prose-invert">
  <!-- Nội dung Markdown của bạn ở đây -->
</div>
```

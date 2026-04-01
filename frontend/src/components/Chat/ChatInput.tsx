import React, { useRef, useEffect, useCallback, useState } from "react"
import { Sparkles, Mic, Square } from "lucide-react"
import { Button } from "@/components/ui/button"

// Web Speech API type declarations
interface ISpeechRecognition extends EventTarget {
  lang: string
  interimResults: boolean
  continuous: boolean
  maxAlternatives: number
  onresult: ((event: any) => void) | null
  onerror: ((event: any) => void) | null
  onend: (() => void) | null
  start(): void
  stop(): void
  abort(): void
}

declare global {
  interface Window {
    SpeechRecognition: new () => ISpeechRecognition
    webkitSpeechRecognition: new () => ISpeechRecognition
  }
}

interface ChatInputProps {
  onSend: (message: string) => void
  isLoading?: boolean
}

const ChatInput: React.FC<ChatInputProps> = ({ onSend, isLoading }) => {
  const [input, setInput] = React.useState("")
  const [isListening, setIsListening] = useState(false)
  const textareaRef = useRef<HTMLTextAreaElement>(null)
  const recognitionRef = useRef<ISpeechRecognition | null>(null)

  const resizeTextarea = useCallback(() => {
    const textarea = textareaRef.current
    if (textarea) {
      textarea.style.height = "auto"
      textarea.style.height = `${Math.min(textarea.scrollHeight, 200)}px`
    }
  }, [])

  useEffect(() => {
    resizeTextarea()
  }, [input, resizeTextarea])

  // Cleanup speech recognition on unmount
  useEffect(() => {
    return () => {
      if (recognitionRef.current) {
        recognitionRef.current.stop()
      }
    }
  }, [])

  const handleKeyDown = (e: React.KeyboardEvent<HTMLTextAreaElement>) => {
    if (e.key === "Enter" && !e.shiftKey) {
      e.preventDefault()
      handleSend()
    }
  }

  const handleSend = () => {
    if (input.trim() && !isLoading) {
      // Dừng ghi âm lập tức trước khi gửi để tránh kết quả dư thừa quay lại ô chat
      if (recognitionRef.current) {
        recognitionRef.current.abort()
        setIsListening(false)
      }

      onSend(input.trim())
      setInput("")
      
      if (textareaRef.current) {
        textareaRef.current.style.height = "auto"
      }
    }
  }

  const toggleVoice = () => {
    // Check browser support
    const SpeechRecognitionAPI =
      window.SpeechRecognition || window.webkitSpeechRecognition

    if (!SpeechRecognitionAPI) {
      alert("Trình duyệt của bạn không hỗ trợ nhận diện giọng nói. Vui lòng sử dụng Chrome hoặc Edge.")
      return
    }

    if (isListening && recognitionRef.current) {
      recognitionRef.current.stop()
      setIsListening(false)
      return
    }

    const recognition = new SpeechRecognitionAPI()
    recognitionRef.current = recognition
    recognition.lang = "vi-VN"
    recognition.interimResults = true
    recognition.continuous = true
    recognition.maxAlternatives = 1

    // Lưu lại nội dung hiện tại để nối thêm
    const baseText = input.trim()

    recognition.onresult = (event: any) => {
      let interimTranscript = ""
      let finalSegment = ""

      for (let i = event.resultIndex; i < event.results.length; ++i) {
        if (event.results[i].isFinal) {
          finalSegment += event.results[i][0].transcript
        } else {
          interimTranscript += event.results[i][0].transcript
        }
      }

      // Cập nhật input: Văn bản cũ + Đoạn đã chốt (final) + Đoạn đang nghe (interim)
      if (finalSegment || interimTranscript) {
        const separator = baseText ? " " : ""
        // Lưu ý: Chúng ta cần giữ link nội dung cũ. 
        // Tuy nhiên SpeechRecognition trong mode continuous sẽ cộng dồn kết quả vào event.results.
        // Nên ta chỉ cần render lại toàn bộ results từ đầu object hoặc xử lý offset.
        
        // Cách tối ưu nhất cho "nối text":
        let fullTranscript = ""
        for (let i = 0; i < event.results.length; ++i) {
          fullTranscript += event.results[i][0].transcript
        }
        
        setInput(baseText + separator + fullTranscript.trim())
      }
    }

    recognition.onerror = (event: any) => {
      console.error("Speech recognition error:", event.error)
      if (event.error === 'not-allowed') {
        alert("Bạn cần cấp quyền truy cập Micro cho trình duyệt để sử dụng tính năng này.")
      }
      setIsListening(false)
    }

    recognition.onend = () => {
      setIsListening(false)
    }

    recognition.start()
    setIsListening(true)
  }

  return (
    <div className="relative mx-auto flex w-full max-w-[800px] flex-col gap-2 px-4 md:px-8">
      <div className="group relative flex w-full items-end overflow-hidden rounded-[26px] bg-muted border border-border transition-all duration-300">
        <textarea
          ref={textareaRef}
          value={input}
          onChange={(e) => setInput(e.target.value)}
          onKeyDown={handleKeyDown}
          placeholder="Hỏi bất kỳ điều gì"
          className="max-h-[200px] min-h-[52px] w-full resize-none border-0 bg-transparent py-3.5 pl-5 pr-14 text-[15px] leading-6 text-foreground placeholder:text-muted-foreground focus:ring-0 focus-visible:ring-0 outline-none"
          rows={1}
          disabled={isLoading}
        />
        <div className="flex h-[52px] shrink-0 items-center justify-center gap-1 pr-2">
          {input.trim() ? (
            <Button
              size="icon"
              disabled={isLoading}
              onClick={handleSend}
              className="h-8 w-8 rounded-full bg-primary hover:bg-primary/90 text-primary-foreground shadow-sm"
              type="button"
            >
              {isLoading ? (
                <Sparkles className="h-4 w-4 animate-pulse" />
              ) : (
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" className="icon-md h-5 w-5" aria-hidden="true">
                  <path fillRule="evenodd" clipRule="evenodd" d="M11.2929 3.29289C11.6834 2.90237 12.3166 2.90237 12.7071 3.29289L19.7071 10.2929C20.0976 10.6834 20.0976 11.3166 19.7071 11.7071C19.3166 12.0976 18.6834 12.0976 18.2929 11.7071L13 6.41421V20C13 20.5523 12.5523 21 12 21C11.4477 21 11 20.5523 11 20V6.41421L5.70711 11.7071C5.31658 12.0976 4.68342 12.0976 4.29289 11.7071C3.90237 11.3166 3.90237 10.6834 4.29289 10.2929L11.2929 3.29289Z" fill="currentColor"/>
                </svg>
              )}
            </Button>
          ) : (
             <Button
               size="icon"
               variant="ghost"
               className={`h-8 w-8 rounded-full transition-all ${
                 isListening
                   ? "text-red-500 bg-red-500/10 hover:bg-red-500/20 hover:text-red-500 animate-pulse"
                   : "text-muted-foreground hover:bg-accent hover:text-foreground"
               }`}
               type="button"
               aria-label={isListening ? "Dừng ghi âm" : "Nhập bằng giọng nói"}
               onClick={toggleVoice}
             >
               {isListening ? (
                 <Square className="h-4 w-4 fill-current" />
               ) : (
                 <Mic className="h-5 w-5" />
               )}
             </Button>
          )}
        </div>
      </div>
      <div className="text-center text-[11px] text-muted-foreground pb-1">
        EduGuide có thể mắc lỗi. Hãy kiểm tra các thông tin quan trọng.
      </div>
    </div>
  )
}

export default ChatInput

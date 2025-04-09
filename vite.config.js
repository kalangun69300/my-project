import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],
  server: {
    host: '0.0.0.0',  // ทำให้สามารถเข้าถึงจากทุก IP
    port: 8080,        // หรือพอร์ตที่คุณต้องการ
  },
})

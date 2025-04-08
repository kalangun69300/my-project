# ใช้ Node.js เป็น Base Image
FROM node:18

# กำหนด Working Directory
WORKDIR /app

# คัดลอกไฟล์ package.json และ package-lock.json ก่อน
COPY package*.json ./

# ติดตั้ง Dependencies
RUN npm ci

# คัดลอกไฟล์ทั้งหมดไปที่ Container
COPY . .

# Build แอป (ใช้ Vite)
RUN npm run build

# เปิด Port 3000 (ของ Vite) 
EXPOSE 3002

# คำสั่งรันแอปพลิเคชัน
CMD ["npx", "serve", "-s", "dist", "-l", "0.0.0.0:3002"]

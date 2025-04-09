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

# เปิด Port 8080
EXPOSE 3002 3002

# คำสั่งรันแอปพลิเคชันด้วย serve ที่พอร์ต 8080
CMD ["npx", "serve", "-s", "dist"]

# กำหนด Health Check เพื่อตรวจสอบว่าแอปทำงานอยู่หรือไม่
HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
  CMD curl --silent --fail http://192.168.172.115:3002 || exit 1

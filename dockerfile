# ใช้ Node.js เป็น Base Image
FROM hubdc.dso.local/test-image/node:23

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
EXPOSE 8080

# คำสั่งรันแอปพลิเคชันด้วย serve ที่พอร์ต 8080
ENTRYPOINT ["npx", "serve", "-s", "dist", "-l", "8080"]

# ตรวจ healthcheck
HEALTHCHECK --interval=10s --timeout=3s --retries=3 \
    CMD curl --fail http://localhost:8080/ || exit 1

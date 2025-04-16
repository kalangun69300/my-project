# ใช้ Node.js เป็น Base Image
FROM hubdc.dso.local/test-image/node:23

# สร้าง user ธรรมดาชื่อ appuser
RUN adduser --system --group dsoadm01

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

# เปลี่ยน owner ของไฟล์ทั้งหมดใน /app ให้เป็น appuser
RUN chown -R dsoadm01:dsoadm01 /app

# เปลี่ยน user สำหรับรัน container
USER dsoadm01

# เปิด Port 8080
EXPOSE 8080

# รันแอปด้วย serve
ENTRYPOINT ["npx", "serve", "-s", "dist", "-l", "8080"]

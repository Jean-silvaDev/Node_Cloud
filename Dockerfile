# Etapa 1: build da aplicação
FROM node:18-alpine AS builder
WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build   # gera os arquivos em dist/

# Etapa 2: imagem final
FROM node:18-alpine
WORKDIR /app

COPY package*.json ./
RUN npm install --only=production

COPY --from=builder /app/dist ./dist

EXPOSE 5000
CMD ["node", "dist/index.js"]
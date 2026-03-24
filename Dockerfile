# dependency stage
FROM node:20 AS deps

WORKDIR /app

COPY package*.json ./
RUN npm install


# build stage
FROM node:20 AS builder

WORKDIR /app

COPY --from=deps /app/node_modules ./node_modules
COPY . .

RUN npm run build


# runtime stage
FROM nginx:alpine

COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80
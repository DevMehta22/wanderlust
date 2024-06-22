#Stage 1
FROM node:22 as Builder

WORKDIR /app

COPY package*.json ./

RUN apt-get update && apt-get install -y git

RUN git init

RUN npm install husky --save-dev

RUN npm install --legacy-peer-deps --verbose

COPY . .

RUN npm run installer

#stage 2
FROM node:22-slim

WORKDIR /app

COPY --from=Builder /app .

COPY ./backned/.env.docker ./backend/.env

RUN cd frontend && npm run build

EXPOSE 8080 5173

CMD ["npm", "run", "start"]

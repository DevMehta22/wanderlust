FROM node:22

WORKDIR /app

COPY package*.json ./

RUN apt-get update && apt-get install -y git


RUN git init

RUN npm install husky --save-dev

RUN npm install --legacy-peer-deps --verbose

COPY . .

RUN npm run installer

RUN cd frontend && npm run build

EXPOSE 8080 5173

CMD ["npm", "run", "start"]

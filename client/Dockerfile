# Stage 0 - Build Frontend Assets
FROM node:12.16.3-alpine as build

WORKDIR /user/src/app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD [ "npm", "start" ]

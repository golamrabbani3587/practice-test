FROM node:16.0.0

RUN mkdir -p /src/app
WORKDIR /src/app

COPY package.json /src/app
RUN npm install

COPY . .
EXPOSE 1011
CMD [ "node", "index.js" ]

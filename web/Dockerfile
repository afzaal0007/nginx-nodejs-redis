# FROM node:14.17.3-alpine3.14

# WORKDIR /usr/src/app

# COPY package.json package-lock.json ./
# RUN npm ci
# COPY ./server.js ./ && COPY ./*.js ./

# CMD ["npm","start"]


FROM node:14

# Create app directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package.json package-lock.json ./

# Install app dependencies
RUN npm install

# Copy all .js and .json files from the web folder
COPY server.js metrics.js package.json package-lock.json ./

EXPOSE 5000
CMD [ "node", "server.js" ]

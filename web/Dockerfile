# FROM node:14.17.3-alpine3.14

# WORKDIR /usr/src/app

# COPY package.json package-lock.json ./
# RUN npm ci
# COPY ./server.js ./ && COPY ./*.js ./

# CMD ["npm","start"]


FROM node:22-alpine

# Create app directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package.json package-lock.json ./

RUN npm install

# RUN npm install -g npm-check-updates && \
#     ncu -u && \
#     npm install --save-dev mocha && \
#     npm audit fix

# Copy all .js and .json files from the web folder
COPY server.js metrics.js package.json package-lock.json ./

EXPOSE 5000
CMD [ "node", "server.js" ]

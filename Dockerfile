# pull the base image
FROM node:lts-buster-slim

# set the working direction
WORKDIR /app

# add `/app/node_modules/.bin` to $PATH
# ENV PATH /app/node_modules/.bin:$PATH

# install app dependencies
COPY package.json ./

COPY package-lock.json ./

RUN npm install

# add app
COPY . ./

RUN npm run build

# start app
CMD ["npm", "start"]


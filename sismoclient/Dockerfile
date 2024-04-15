FROM node:16

WORKDIR /sismoclient

# copiar 'package.json' y 'package-lock.json' (si están disponibles)
COPY package*.json ./

# install app dependencies
RUN npm install

# add app
COPY . ./
ENV NODE_ENV development
EXPOSE 4000

# start app
CMD ["npm", "start"]
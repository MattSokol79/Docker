# Select the latest image to work from
FROM node:latest

# Who edited this docker file
LABEL MAINTAINER-msokol@spartaglobal.com

# Choose the working directory
WORKDIR /usr/src/app

# 1. (. = copy whole current directory) 2. (. = to current working directory)
COPY . .

# Install npm
RUN npm install 

# Default port 3000
EXPOSE 3000

# Start app with CMD | node
CMD ["node", "app.js"]


# Dockerise the NodeJS app
## Dev Environment
1. Within the directory containing the app, create a `Dockerfile` which will be used to build the image
2. Inside the `Dockerfile` write the following commands:

```docker
# Select the latest image to work from
FROM node:latest

# Who edited this docker file
LABEL MAINTAINER=msokol@spartaglobal.com

# Choose the working directory -> Creates the app directory
WORKDIR /usr/src/app

# 1. (. = copy whole current directory) 2. (. = to current working directory i.e. /usr/src/app)
COPY . .

# Install npm -> Need it to run app
RUN npm install 

# Default port 3000
EXPOSE 3000

# Start app with CMD | node
CMD ["node", "app.js"]
```

3. Whilst inside the directory containing the `Dockerfile`, build this image with the following command:
```docker
docker build -t matt791/eng74-matt-app-docker 
```

4. Check to see if it runs correctly by running the image first on a port e.g. port 80 for ease so `localhost` in browser:
```docker
docker run -d -p 80:3000 matt791/eng74-matt-app-docker
```

5. Navigate to your browser and type `localhost` and you should see the app working with `/fibonacci/<number>` working too.

6. Now that the app works, you can create a DockerHub Repository for this image and push to it with the following commands:
```docker
docker commit <container_id> matt791/eng74-matt-app-docker
docker push matt791/eng74-matt-app-docker
```

7. Now the image is Publicly available on your DockerHub and can be ran by anybody with the repo name:
`matt791/eng74-matt-app-docker`

## Multi-Stage Environment
- The idea behind doing is, is the fact that initally, we create a container with a big image to make sure everything works, and then you turn the image to something much more lightweight to save resources
- Multi stage code found below built as `prod-nodejs-app` -> Used `node:alpine` which is much slimmer than just `node`, turned 937MB to 137MB.

```docker
# Select the latest node image to work from
FROM node as App

# Who edited this docker file
LABEL MAINTAINER=msokol@spartaglobal.com

# Choose the working directory
WORKDIR /usr/src/app

# 1. (. = copy whole current directory) 2. (. = to current working directory)
COPY . .

# Install npm
RUN npm install 

#####################
# Second stage -> Multi Stage Docker build
FROM node:alpine

# Magical line -> Copies only essential things to the layer
# Compresses the size, creates a lighter weight image
COPY --from=App /usr/src/app /usr/src/app

WORKDIR /usr/src/app

# Default port 3000
EXPOSE 3000

# Start app with CMD | node
CMD ["node", "app.js"]
```
- ***Build*** the image with:
`docker build -t prod-nodejs-app .`

- ***Run*** this with:
`docker run -d --name prod-app -p 80:3000 prod-nodejs-app`

### Push to a NEW DockerHub repo -> Production
```docker
docker commit <container_id> matt791/prod-nodejs-app
docker push matt791/prod-nodejs-app
```

# Multi-stage connected to Mongod
- In order to connect the App to the mongodb, the easiest way to achieve this is by creating a `docker-compose.yaml` file in the same directory as the `Dockerfile` which creates the app

**DB**
- First run the mongodb container from within by pulling in the official image of a mongo from the web and specifying port 27017.
- `.conf` file needs to be substituted in to allow access to the db

**App**
- Builds the app from the Dockerfile which is also situated in this directory and specifies the DB_HOST as the ip of the mongo above it by a **link**.
- Runs on port 3000 

### Code
```yaml
version: "3"
services:
  mongo:
    container_name: mongo_db

    # Pulling the mongodb image from the web
    image: mongo

    # Restart the container whenever file is ran
    restart: always

    # Port 27017 as thats the port to access db
    ports:
      - "27017:27017"
    volumes: 
      - ./mongod.conf:/etc/mongod.conf
 

  app:
    container_name: prod-nodejs-app

    # Build the container from the current directory
    build: .
    
    # Specify DB_HOST for app to run posts/ 
    environment:
      - DB_HOST=mongodb://mongo:27017/posts 

    # Link the db to app    
    links:
      - mongo
    ports:
      - "3000:3000"
    
```


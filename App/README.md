# Dockerise the NodeJS app
1. Within the directory containing the app, create a `Dockerfile` which will be used to build the image
2. Inside the `Dockerfile` write the following commands:

```docker
# Select the latest image to work from
FROM node:latest

# Who edited this docker file
LABEL MAINTAINER-msokol@spartaglobal.com

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
# Docker
- Containerisation - Packaging code together which can be ran from any environment
- Containerisation software is very light weight compared to vagrant, or other software i.e. its Faster!
## What is Docker?

![](img/Docker.png)

- Docker is an open source platform **DockerHub documentation** 
- Containerisation software - It enables us to separate applications from the infrastructure
- It allows us to deliver software faster! Much more light weight than Vagrant and other software
- Written in **GO** language

[Docker Overview](https://docs.docker.com/get-started/overview/)

## Why Docker
- Multi billion dollar companies are using or adapting Docker i.e. Ebay, Netflix, Sky 
- Docker adoption is anticipated by 50% by the end of 2020 
- It allows us to deliver software faster! Much more light weight than Vagrant and other software

## What is the difference between a VM and Docker

![](img/docker_explained.svg)

- Docker is light weight and user friendly 
- Docker shares the resources of OS as opposed to using the OS completely 
- Docker engine connects the container with OS and only uses the resources required
- VM works with Hypervisor to connect guest OS/VM with Host OS/server

## Docker Commands
- `docker pull <name_of_image>` 
- `docker run <name_of_image> or hello-world` -> To see docker installation running correctly
- `docker build -t <name_of_image>`
- `docker commit <name_of_image/container_id>`  
  
- `docker images` -> To see current images 
- `docker start <name_of_image/container_id>` -> Starts container
- `docker stop <name_of_image/container_id>` -> Stops container
- `docker rm <name_of_image/container_id>` -> Removes container
- `docker ps and ps -a <name_of_image/container_id>` -> to check the existing containers like `ls` !!!

## Logging into a running container 
- `docker exec -it <name_of_image/container_id>` -> Go inside the container very similar to `vagrant up and ssh into that vm` -> ***MUCH FASTER*** THAN vagrant 

- `-d` means detached and `-p` means ports and you specify the ports after, the first being the port be can use to connect from localhost and second is the one docker will use
- `docker run -d -p 80:80 nginx` -> Installs nginx on `localhost:80` in seconds
- `docker run -d -p 2368:2369 ghost` -> Installs ghost on `localhost:2368` in browser

### Making docker docs available on our localhost
- `docker run -d -p 4000:4000 docs/docker.github.io` -> Downloads DockerHub onto `localhost:4000`

- ***Port mapping in containers:***
  - `docker run -d -p localhost-port:container-port <image>`
  - e.g. `docker run -d -p 4001:4000 image` -> It will run on `localhost:4001` NOT `4000` as before

### Adding html to nginx IMPORTANT!!!!!
- Create a `index.html` file with some text 
- `docker exec -it <ID of nginx> bash` -> Didnt work on windows Bash
- FIX -> `alias docker="winpty docker"` -> Now just write the same command so you essentially hide winpty behind docker

- Once inside the container in bash:
  - `apt-get update -y`
  - `uname -a` -> Find out name of machine 
  - Path to HTML -> `/usr/share/nginx/html/index.html`

### Copying files into a running container 
**To copy in a `index.html` file into the running container:**
(Make sure to specify the file at the end to overwrite it!)
- `docker cp filepath/filename <container_id>:filepath/filename` 
- e.g.:
- `docker cp index.html 13f11cef9fcd:usr/share/nginx/html/index.html`
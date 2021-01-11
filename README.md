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
- Docker is light weight and user friendly 
- Docker shares the resources of OS as opposed to using the OS completely 
- Docker engine connects the container with OS and only uses the resources required
- VM works with Hypervisor to connect guest OS/VM with Host OS/server

## Docker Commands
- `docker pull <name_of_image>` 
- `docker run <name_of_image> or hello-world` -> To see docker installation running correctly
- `docker build -t <name_of_image>`
- `docker commit <name_of_image/container_id>`  
- `docker start <name_of_image/container_id>`
- `docker stop <name_of_image/container_id>`
- `docker rm <name_of_image/container_id>`
- `docker ps and ps -a <name_of_image/container_id>` -> to check the existing containers like `ls` !!!

## Logging into a running container 
- `docker exec -it <name_of_image/container_id>` -> Go inside the container very similar to `vagrant up and ssh into that vm` -> ***MUCH FASTER*** THAN vagrant 
Docker Concepts:

Docker is a platform for developers and sysadmins to develop, deploy, and run applications with containers.
The use of Linux containers to deploy applications is called containerization.
Containers are not new, but their use for easily deploying applications is.

Containerization is increasingly popular because containers are:

Flexible: Even the most complex applications can be containerized.
Lightweight: Containers leverage and share the host kernel.
Interchangeable: You can deploy updates and upgrades on-the-fly.
Portable: You can build locally, deploy to the cloud, and run anywhere.
Scalable: You can increase and automatically distribute container replicas.
Stackable: You can stack services vertically and on-the-fly.


Images and containers
A container is launched by running an image. An image is an executable package that includes everything
needed to run an application--the code, a runtime, libraries, environment variables, and configuration files.

A container is a runtime instance of an image--what the image becomes in memory when executed
(that is, an image with state, or a user process). You can see a list of your running containers with the command,
docker ps, just as you would in Linux.


Containers and virtual machines
A container runs natively on Linux and shares the kernel of the host machine with other containers.
It runs a discrete process, taking no more memory than any other executable, making it lightweight.

By contrast, a virtual machine (VM) runs a full-blown “guest” operating system with virtual access to host
resources through a hypervisor. In general, VMs provide an environment with more resources than most applications need.

Install Docker on Ubutnu
sudo apt-get remove docker docker-engine docker.io
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable edge test"
sudo apt update
sudo apt install docker-ce
sudo usermod -aG docker $USER
sudo docker run hello-world

$ docker image ls
$ docker container ls --all

Recap and cheat sheet
## List Docker CLI commands
docker
docker container --help

## Display Docker version and info
docker --version
docker version
docker info

## Execute Docker image
docker run hello-world

## List Docker images
docker image ls

## List Docker containers (running, all, all in quiet mode)
docker container ls
docker container ls --all
docker container ls -aq

Build Image
docker build --tag=flaskhapp:v0.0.1 .

# Set proxy server, replace host:port with values for your servers
ENV http_proxy host:port
ENV https_proxy host:port

DNS Settings
/etc/docker/daemon.json with the dns key, as following:

{
  "dns": ["your_dns_address", "8.8.8.8"]
}

Run the app
Run the app, mapping your machine’s port 4000 to the container’s published port 80 using -p:

docker run -p 4000:80 flask

http://0.0.0.0:80

$ docker container ls

Run in the background
docker run -d -p 4000:80

Stop container with ID
docker container stop <containerid>

A registry is a collection of repositories, and a repository is a collection of images—sort of like a GitHub repository,
except the code is already built. An account on a registry can create many repositories. 
The docker CLI uses Docker’s public registry by default.

docker tag image username/repository:tag

Push image to public
docker push username/repository:tag

Run docker container
docker run -p 5000:80 9538253250/testing:latest

Get the ipaddress of docker container
docker inspect  2c8f59c4cd14 | grep IPAddress

docker run --name containername -it  centos /bin/bash
docker run --name pso -it psoportal:v0.0.1 /bin/bash

docker swarm init
docker swarm leave
docker swarm leave --force
docker swarm join --token SWMTKN-1-4i4knr4xnbz7ti8tgw8utc1243r13kbd8ui1tb7vmapr7njdw0-der121xbosee0fg0x6bn7ce5n 192.168.0.7:2377
docker swarm join-token manager

$ vim docker-compose.yaml
$ docker stack deploy -c docker-compose.yaml getwebapp
Creating network getwebapp_webnet
Creating service getwebapp_web
$ docker container ls
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
[sadashiv@sadashiv-ThinkPad-E480 docker (master #)]$ docker image ls
REPOSITORY           TAG                 IMAGE ID            CREATED             SIZE
psoportal            v0.0.1              0b00f67f0940        50 minutes ago      578MB
9538253250/testing   latest              6e68729d7a56        29 hours ago        148MB
flask                latest              6e68729d7a56        29 hours ago        148MB
testing              latest              6e68729d7a56        29 hours ago        148MB
python               2.7-slim            f462855313cd        2 weeks ago         137MB
centos               latest              67fa590cfc1c        5 weeks ago         202MB
hello-world          latest              fce289e99eb9        9 months ago        1.84kB

$ docker service ls
ID                  NAME                MODE                REPLICAS            IMAGE                       PORTS
1kv11tg86qtm        getwebapp_web       replicated          5/5                 9538253250/testing:latest   *:4000->80/tcp

$ docker stack services getwebapp
ID                  NAME                MODE                REPLICAS            IMAGE                       PORTS
1kv11tg86qtm        getwebapp_web       replicated          5/5                 9538253250/testing:latest   *:4000->80/tcp

$ docker service ps getwebapp_web
ID                  NAME                IMAGE                       NODE                     DESIRED STATE       CURRENT STATE           ERROR               PORTS
o3k1cqgn0icz        getwebapp_web.1     9538253250/testing:latest   sadashiv-ThinkPad-E480   Running             Running 7 minutes ago
azf2d28tgyas        getwebapp_web.2     9538253250/testing:latest   sadashiv-ThinkPad-E480   Running             Running 7 minutes ago
x906d5yuizk2        getwebapp_web.3     9538253250/testing:latest   sadashiv-ThinkPad-E480   Running             Running 7 minutes ago
le5wsh2za9o3        getwebapp_web.4     9538253250/testing:latest   sadashiv-ThinkPad-E480   Running             Running 7 minutes ago
6pqrm99y44wa        getwebapp_web.5     9538253250/testing:latest   sadashiv-ThinkPad-E480   Running             Running 7 minutes ago

$ docker container ls -q
174611f33d37
7dddb75553ae
85a89bcc3c38
92598eb43dd6
fbc1ef55e56b


docker stack ls                                            # List stacks or apps
docker stack deploy -c <composefile> <appname>  # Run the specified Compose file
docker service ls                 # List running services associated with an app
docker service ps <service>                  # List tasks associated with an app
docker inspect <task or container>                   # Inspect task or container
docker container ls -q                                      # List container IDs
docker stack rm <appname>                             # Tear down an application
docker swarm leave --force      # Take down a single node swarm from the manager

Docker Registry (Docker Trusted Registry – DTR) is an enterprise-grade storage solution for Docker images.
In other words, it’s an image storage service. Think about GitHub, but for Docker Images.

Docker Repository is a collection of Docker images with the same name and different tags.
For example, the repository we’ve used several times so far, microsoft/aspnetcore has a bunch
of images with different tags in it. We can choose which one you want to pull by typing docker
pull image-name:tag. Something similar to GitHub repo and commits. We can go back to whichever
commit we want and pull it to the local machine.

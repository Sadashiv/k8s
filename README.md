Docker Concepts:
https://kapeli.com/cheat_sheets/Dockerfile.docset/Contents/Resources/Documents/index

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

Docker server also called engine
docker version -> verified cli can task to engine
docker info ->Most config values of engine

Old and new way of running docker commands
docker container run - new way of run
docker run - Oold way of run

Images and containers
A container is launched by running an image. An image is an executable package that includes everything
needed to run an application the code, a runtime, libraries, environment variables, and configuration files.

A container is a runtime instance of an image --what the image becomes in memory when executed
(that is, an image with state, or a user process). You can see a list of your running containers with the command,
docker ps, just as you would in Linux.

Image vs Container
Image contains binaries, libraries and source code all make to run application
Container is instance of that image running as process
Docker default image registry is called docker hub(hub.docker.com)

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

Uninstall docker
sudo apt-get purge -y docker-engine docker docker.io docker-ce
sudo apt-get autoremove -y --purge docker-engine docker docker.io docker-ce
sudo rm -rf /var/lib/docker /etc/docker
sudo rm /etc/apparmor.d/docker
sudo groupdel docker
sudo rm -rf /var/run/docker.sock


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

--> Always create docker container then start and attache to enter into the container
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

curl -fsSL get.docker.com -o get-docker-ce.sh
RHEL EE need docker EE
docker doesn't support normal sudo user to run command

#Build docker image
sudo docker image build -t apache:1.1 . -f Dockerfile_apache
#Run container using the above image built
sudo docker container run -p 8009:80 -d --name apache apache:1.1
sudo docker container rm --force apache

--publish 80:80
first 80 port to access(expose port) in browser and second one is container port.
docker container run --publish 80:80 nginx - fg
docker container run --publish 80:80 --detach nginx - Service/Daemon
sudo docker create --name centos_7 centos
sudo docker container start centos_7
docker container stop <containerid>
docker container ls - List running container
docker container ls -a - List all container stop/start

Into the container
$ sudo docker container attach 3e3e141c722a
or
$ sudo docker exec -it dff9974acdf0  /bin/bash

docker container run --publish 80:80 --detach nginx - Service
docker container run --publish 80:80 --detach nginx --name <name_of_container>(should be unique)
docker container rm <container_id>
docker container stop <container_id>(-f forcefully)

docker top <image_name> - List running process in specific container
docker container logs <container_id>
docker container inspect <container_name> - Give the json data
docker container stats <container_id>/<container_name>
docker container stats - All container stats

docker container run -it --name xyz ubuntu - Start new container interactively
docker container exec -it ubuntu - Run additional command in existing container
docker container start -ai ubuntu
docker container exec -it 9e0153426878 bash

When you start docker container in the background connecting to particular docker network and by default bridge network
Each network routes through NAT firewall on host IP

docker container port <container_id>
docker continaer ipaddress

Find IPAddress of container
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' 9e0153426878

docker network ls
docker network inspect bridge
docker network create <create_custome_network>
docker network ls
docker cotainer connect <network_id> <container_id>
docker container exec -it <frst_cotainer_id_nginx> ping <second_container_id_nginx>
Always create custom network

Image: Image is an ordered collection of root filesystem changes and the corresponding execution parameters for use within container runtime.
Not complete os, no kernel, kernel modules(eg drivers)

docker history centos
docker image inspect centos - metadata(data about data)
docker image tag nginx 9538253250/nginx - Create tag in the repo pointing to local
docker push username/image

build docker image using Dockerfile
If the file is different one use -f filename
docker build -f DockerFile_memcached

sudo docker build -t apache -f Dockerfile_apache .
sudo docker tag 36b90ca05482 9538253250/apache - Tags local image id with user registry so that can be push to registry
sudo docker push 9538253250/apache - Push to registry

DockerFile
FROM centos:latest
ENV A B #export A=B
RUN ls #Execute commands
EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"] # This will be performed when container is launched
WORKDIR /app -> RUN cd /app
#Volume attach -v.
#VOLUME /var/run/mysql
docker container run -d --name nginx -p 80:80 -v $(pwd):/usr/share/nginx/html nginx

Above all called the layers of image to build

Container lifetime and Persitent data
Two way : Data volumes and Bind mounts
Volumes: make special location outside of container UFS
Bind Mounts: link container path to host path

sudo docker container run --name mysql -e MYSQL_ALLOW_EMPTY_PASSWORD=True mysql

docker volume ls
DRIVER              VOLUME NAME
local               58f68ed02559cdcd309ab47165407b692c4be1dfd173d18f20ac6ef0a6d4b578
post deletiion of our container the data will be persistent

sudo docker container run -d --name mysql1 -e MYSQL_ALLOW_EMPTY_PASSSWORD=True -v /var/lib/mysql mysql
sudo docker container run -d --name mysql2 -e MYSQL_ALLOW_EMPTY_PASSSWORD=True -v mysql-db:/var/lib/mysql mysql - named volume(-v mysql-db:/var/lib/m#

Bind mount
maps host file or directory to container file or directory
Docker_nginx and build and start container
sudo docker build -t custom_nginx -f Dockerfile_nginx .
sudo docker container run  -d  --name nginx -p 8075:80 -v $(pwd):/usr/share/nginx/html custom_nginx
Change in the host file is going to take precdence
#47 important

Docker compose
Comprised of two seperate but related things
 1. YAML-formatted file that describes our solution option for
    * continers
    * networks
    * Volumes

 2. A CLI Tool docker-compose used for local dev/test automation with those YAML files.

Docker compose is talking to the docker API in the background on behalf of docker CLI, is kind of replacement for CLI.

COPY and ADD are both Dockerfile instructions that serve similar purposes.
They let you copy files from a specific location into a Docker image.

COPY takes in a src and destination. It only lets you copy in a local file or directory
from your host (the machine building the Docker image) into the Docker image itself.

ADD lets you do that too, but it also supports 2 other sources.
First, you can use a URL instead of a local file / directory.
Secondly, you can extract a tar file from the source directly into the destination.

RUN executes command(s) in a new layer and creates a new image. E.g., it is often used for installing software packages.
CMD sets default command and/or parameters, which can be overwritten from command line when docker container runs.
ENTRYPOINT configures a container that will run as an executable.
ENTRYPOINT ab 
With the ENTRYPOINT instruction, it is not possible to override the instruction during
the docker run command execution like we are with CMD. This highlights another usage of ENTRYPOINT,
as a method of ensuring that a specific command is executed when the container in question is started
regardless of attempts to override the ENTRYPOINT.

$sudo docker container run -i -t --rm -p 80:80 nginx #Run foreground and remove container once it stops

FROM ubuntu
ENTRYPOINT ["top", "-b"]
CMD ["-c"]

$sd container run -it --rm --name test11 ubuntu top -H

VOLUME
VOLUME ["/data"]


USER
USER <user>[:<group>] or
USER <UID>[:<GID>]

WORKDIR
WORKDIR /path/to/workdir

WORKDIR /a
WORKDIR b
WORKDIR c
RUN pwd
The output of the final pwd command in this Dockerfile would be /a/b/c.

ARG
ARG <name>[=<default value>]
The ARG instruction defines a variable that users can pass at build-time to the builder with the
docker build command using the --build-arg <varname>=<value> flag. If a user specifies a build
argument that was not defined in the Dockerfile, the build outputs a warning.




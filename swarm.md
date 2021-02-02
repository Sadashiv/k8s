Containers Everywhere=New
Dcoker container command don't have feature to scale up/down
By using the swarm we can achieve it

Swarm mode build in orachestration
-Swarm mode is clustering solution built inside docker

By default the docker swarm is inactive
you can make it acitve by command

$sudo docker init
 Root signing ceritificate created for our own
 Ceritficate issued for first manager
 Join tokens are created
 In background raft database created to store CA, config and secrets

$sudo docker node ls
 Only one leader at time
 ID                            HOSTNAME                 STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
 huu78rhltkz9q4dgkrxq7vo6x *   sadashiv-ThinkPad-E480   Ready               Active              Leader              19.03.3

$sudo docker serivce ls
$sudo docker container ls

[sadashiv@sadashiv-ThinkPad-E480 docker (master )]$ sd service ls
ID                  NAME                MODE                REPLICAS            IMAGE               PORTS
3ci600stgkx4        cocky_swartz        replicated          1/1                 apache:latest
od692nddop49        hopeful_raman       replicated          1/1                 apache:1.1
38q56z7m5wjh        vibrant_lamarr      replicated          1/1                 centos:latest
[sadashiv@sadashiv-ThinkPad-E480 docker (master )]$ sudo docker service update 3ci600stgkx4 --replicas 3


[sadashiv@sadashiv-ThinkPad-E480 docker (master )]$ sd service rm cocky_swartz hopeful_raman vibrant_lamarr
cocky_swartz
hopeful_raman
vibrant_lamarr

[sadashiv@sadashiv-ThinkPad-E480 docker (master )]$ sd service ls
ID                  NAME                MODE                REPLICAS            IMAGE               PORTS

[sadashiv@sadashiv-ThinkPad-E480 docker (master )]$ sd container ls
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES

That's how the orchestration works and it brins up container if any continer goes down





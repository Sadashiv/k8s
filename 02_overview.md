Kubernetes
==========
Kubernetes is a portable, extensible, open source platform for managing containerized workloads and services, that facilitates both declarative configuration and automation.
Kubernetes Popular container orachestration or managing containerized workloads and services
Container orachestration = Make many servers act like once

![Going back in time](images/container_evolution.svg)

Runs on to Docker (usually) as a set of API containers
Provides API/CLI to manage containers across servers
kubelet: kubernetes agent running on nodes
Swarm doesn't need agent
kubernetes also called k8s or k-eights
Contorl panel: Set of containers that manage the cluster()
https://labs.play-with-k8s.com or https://www.katacoda.com
Pod: one or more containers running together on one node
Basic unit of deployment. Containers are always in pod
Controller: For creating/updating pods and other projects
Serivce: Network end point to connect to a pod

Three ways to create pods from the kubectl CLI
kubectl run (Changing to be only for pod creation)
kubectl create (Create some resources via CLI or YAML)
kubectl apply (Create/Update anything via YAML)

List all the resource in kuberenets-> kubectl api-resources
What imperative and Declarative
Imperative -> Give the direction from start to end(CLI)
Declarative -> Only start and end will be already defined

In kubernetes imperative
kubectl get pods
kubectl run nginx --image=nginx

Declarative
kubectl apply -f nginx.yaml #Identify changes and apply

$ kubectl run nginx-pod --image=nginx:alpine
$ kubectl run redis --image=redis:alpine -l tier=db
$ kubectl expose pod redis --port=6379 --name redis-service
$ kubectl create deploy webapp --image=kodekloud/webapp-color --replicas=3
$ kubectl run custom-nginx --image=nginx --port=8888
$ kubectl create ns dev-ns
$ kubectl create deployment redis-deploy --image=redis --namespace=dev-ns --dry-run=client -o yaml > deploy.yml
$ kubectl apply -f deploy.yml
$ kubectl run httpd --image=httpd:alpine --port=80 expose
$ kubectl run httpd --image=httpd:alpine --port=80 --expose
$ kubectl run httpd1 --image=httpd:alpine --port=80 --expose

Install kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
/usr/local/bin/kubectl version

Install using the native package management
Ubuntu

sudo apt update && sudo apt upgrade 
sudo apt-get update && sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl
kubectl  version
which kubectl

RHEL
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
yum install -y kubectl

The Kubernetes Master is a collection of three processes that run on a single node in your cluster, 
which is designated as the master node. Those processes are: kube-apiserver, kube-controller-manager and kube-scheduler.
Each individual non-master node in your cluster runs two processes:
kubelet, which communicates with the Kubernetes Master.
kube-proxy, a network proxy which reflects Kubernetes networking services on each node.

$ kubectl  version
Client Version: version.Info{Major:"1", Minor:"16", GitVersion:"v1.16.3", GitCommit:"b3cbbae08ec52a7fc73d334838e18d17e8512749",
                             GitTreeState:"clean", BuildDate:"2019-11-13T11:23:11Z", GoVersion:"go1.12.12", Compiler:"gc",
                             Platform:"linux/amd64"}
The connection to the server localhost:8080 was refused - did you specify the right host or port?


Docker and kubernetes installation in Ubuntu 18.04LTS
=====================================================
sudo apt update -y
sudo apt install docker.io
sudo apt install containerd
sudo chmod 755 /home/sadashiv/.docker/config.json
docker --version
sudo systemctl enable docker.service
sudo systemctl restart docker
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
sudo apt install kubeadm
kubeadm version
kubectl
sudo swapoff -a
sudo hostnamectl set-hostname master-node
hostnamectl set-hostname slave-node
kubectl get pods
sudo kubeadm init --pod-network-cidr=10.244.0.0/16
sudo kubeadm init --pod-network-cidr=10.244.0.0/16
cat /etc/resolv.conf
sudo vim /etc/resolv.conf
nameserver 8.8.8.8
nameserver 8.8.4.4
sudo kubeadm reset #If already the service of kube related running
sudo systemctl restart kubelet
sudo kubeadm init --pod-network-cidr=10.244.0.0/16
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config

Once complete above step will below details

[addons] Applied essential addon: CoreDNS
[addons] Applied essential addon: kube-proxy

Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

$ sudo systemctl enable docker.service
$ sudo service kubelet restart

Start Rancher in ubuntu
docker run -d --restart=unless-stopped -p 8080:8080 rancher/server:stable

$ kubectl get nodes

Notes: If the port refuses to be connected, please add the following command.

$ export KUBECONFIG=$HOME/admin.conf

Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 192.168.0.100:6443 --token g19lay.oh7p7alpv78rjn0r \
    --discovery-token-ca-cert-hash sha256:81510cce66ce3d6c5aee599d2b2edc4690e14b78caad06b822577d4c7826f802


minikube start
minikube addons list
minikube addons enable dashboard metrics-server
minikube dashboard

kubectl create -f django-definition.yaml 
kubectl get namespace
kc expose pod simpleapppod --type=NodePort
minikube service simpleapppod
http://192.168.49.2:31688/

$ minikube service simpleapppod
|-----------|--------------|-------------|---------------------------|
| NAMESPACE |     NAME     | TARGET PORT |            URL            |
|-----------|--------------|-------------|---------------------------|
| default   | simpleapppod |        8000 | http://192.168.49.2:31688 |
|-----------|--------------|-------------|---------------------------|
🎉  Opening service default/simpleapppod in default browser...


Required Fields 
In the .yaml file for the Kubernetes object you want to create, you'll need to set values for the following fields:

apiVersion - Which version of the Kubernetes API you're using to create this object
kind - What kind of object you want to create
metadata - Data that helps uniquely identify the object, including a name string, UID, and optional namespace
spec - What state you desire for the object

Management technique	Operates on	Recommended environment	Supported writers	Learning curve
Imperative commands	Live objects	Development projects	1+	Lowest
Imperative object configuration	Individual files	Production projects	1	Moderate
Declarative object configuration	Directories of files	Production projects	1+	Highest


Create the objects defined in a configuration file:
kubectl create -f nginx.yaml

Delete the objects defined in two configuration files:
kubectl delete -f nginx.yaml -f redis.yaml

Update the objects defined in a configuration file by overwriting the live configuration:
kubectl replace -f nginx.yaml

kubectl diff -f configs/
kubectl apply -f configs/

Recursively process directories:

kubectl diff -R -f configs/
kubectl apply -R -f configs/

kubectl get nodes
NAME                     READY   STATUS        RESTARTS   AGE
nginx-58687bd566-hptgm   1/1     Running       0          44s
nginx-58687bd566-vm4k6   1/1     Running       0          44s
simpleapppod             1/1     Running       0          12m

kubectl expose pod nginx-58687bd566-vm4k6  --type=NodePort
service/nginx-58687bd566-vm4k6 exposed

minikube service nginx-58687bd566-vm4k6

kubectl get pods --namespace=default
NAME                     READY   STATUS    RESTARTS   AGE
nginx-58687bd566-hptgm   1/1     Running   0          7m29s
nginx-58687bd566-vm4k6   1/1     Running   0          7m29s
simpleapppod             1/1     Running   0          18m

kubectl run nginx --image=nginx --namespace=sada


kubectl config set-context --current --namespace=sada
Context "minikube" modified.

kubectl config view --minify|grep namespace:
    namespace: sada

Namespaces and DNS

When you create a Service, it creates a corresponding DNS entry. This entry is of the form <service-name>.<namespace-name>.svc.cluster.local

kubectl api-resources --namespaced=true
kubectl api-resources --namespaced=false

Labels and Selectors
Labels are key/value pairs that are attached to objects, such as pods.

The kubernetes.io/ and k8s.io/ prefixes are reserved for Kubernetes core components.

A label selector, the client/user can identify a set of objects. The label selector is the core grouping primitive in Kubernetes.
Equality-based -> =, ==, !=
Set-based -> in, notin, exists

equality-based one may write(-l or --selector):
kubectl get pods -l environment=production,tier=frontend

or using set-based requirements:
kubectl get pods -l 'environment in (production),tier in (frontend)'

annotatiions -> 
You can use Kubernetes annotations to attach arbitrary non-identifying metadata to objects.
Clients such as tools and libraries can retrieve this metadata.
Used to collect information like buildversion:1.0 etc

Field Selector
kubectl get pods --field-selector status.phase=Running
NAME    READY   STATUS    RESTARTS   AGE
nginx   1/1     Running   0          109m

You can use the =, ==, and != operators with field selectors 

Chained selectors
kubectl get pods --field-selector=status.phase!=Running,spec.restartPolicy=Always

Multiple resource types
kubectl get statefulsets,services --all-namespaces --field-selector metadata.namespace!=default

Nodes
Kubernetes runs your workload by placing containers into Pods to run on Nodes

To mark a Node unschedulable, run:
kubectl cordon $NODENAME

kubectl describe pods simpleapppod
kubectl describe node minikube

Schedular can be assigned in yaml file specifying the  nodeName: node02

If the pod is already created and want to assign nodename
by binding object and send a post request

apiVersion: v1
kind: Binding
metadata:
  name: nginx
target:
  apiVersion: v1
  kind: Node
  name: node02

Then convert yaml file into json format

nodeSelctor to assign particuar pod to particular node with respect reource constraint
nodeaffinity -> pods are hosted on particular nodes

Resources for pods can defined in yaml file

static pods
/etc/kubernetes/manifests without api server to create static pods
docker ps
kubelete can create pods with below ways
kubelet take input from diffrent ways like pod definition.yaml
static file folder
http api endpoint

if kubelete is part of cluster api then it creates pods in worker node as well as master node(kubectl) and read only in kubectl

deployment-definition.yaml
kubectl expose deployment simpleapppod --type=NodePort --name=simpleapp-service

Kubernetes provides several built-in workload resources:

Deployment and ReplicaSet (replacing the legacy resource ReplicationController).
Deployment is a good fit for managing a stateless application workload on your cluster,
where any Pod in the Deployment is interchangeable and can be replaced if needed.

StatefulSet lets you run one or more related Pods that do track state somehow.
For example, if your workload records data persistently, you can run a StatefulSet that matches each Pod with a PersistentVolume.
Your code, running in the Pods for that StatefulSet, can replicate data to other Pods in the same StatefulSet to improve overall resilience.

DaemonSet defines Pods that provide node-local facilities.
These might be fundamental to the operation of your cluster, such as a networking helper tool, or be part of an add-on.
Every time you add a node to your cluster that matches the specification in a DaemonSet,
the control plane schedules a Pod for that DaemonSet onto the new node.

Job and CronJob define tasks that run to completion and then stop.
Jobs represent one-off tasks, whereas CronJobs recur according to a schedule.

Here are some examples of workload resources that manage one or more Pods:

 Deployment
 StatefulSet
 DaemonSet


Here are the possible values for phase:

Pending -> The Pod has been accepted by the Kubernetes cluster,
           but one or more of the containers has not been set up and made ready to run.
           This includes time a Pod spends waiting to be scheduled as well as the time spent downloading container images over the network.

Running -> The Pod has been bound to a node, and all of the containers have been created.
           At least one container is still running, or is in the process of starting or restarting.
Succeeded -> All containers in the Pod have terminated in success, and will not be restarted.
Failed -> All containers in the Pod have terminated, and at least one container has terminated in failure.
          That is, the container either exited with non-zero status or was terminated by the system.
Unknown -> For some reason the state of the Pod could not be obtained.
           This phase typically occurs due to an error in communicating with the node where the Pod should be running.

Note: When a Pod is being deleted, it is shown as Terminating by some kubectl commands.
      This Terminating status is not one of the Pod phases. A Pod is granted a term to terminate gracefully,
      which defaults to 30 seconds. You can use the flag --force to terminate a Pod by force.


A Pod has a PodStatus, which has an array of PodConditions through which the Pod has or has not passed:

PodScheduled: the Pod has been scheduled to a node.
ContainersReady: all containers in the Pod are ready.
Initialized: all init containers have started successfully.
Ready: the Pod is able to serve requests and should be added to the load balancing pools of all matching Services.

kubectl create deployment simpladd-deployment --image=9538253250/simpleapp:1.0 --dry-run=client -o yaml

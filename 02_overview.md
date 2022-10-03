Kubernetes
==========
 Kubernetes is a portable, extensible, open source platform for managing containerized workloads and services, that facilitates both declarative configuration and automation.
 Kubernetes Popular container orachestration or managing containerized workloads and services
 Container orachestration = Make many servers act like once

 ![Going back in time](images/container_evolution.svg)

 Runs on to Docker (usually) as a set of API containers
 Provides API/CLI to manage containers across servers

Continer deployment
 loosely coupled for deployment and immutable images with that easly rollback or upgrade
 Agile application creation and deployment: increased ease and efficiency of container image creation compared to VM image use.
 Environmental consistency across development, testing, and production: Runs the same on a laptop as it does in the cloud.
 Cloud and OS distribution portability: Runs on Ubuntu, RHEL, CoreOS, on-premises, on major public clouds, and anywhere else.
 Resource isolation: predictable application performance.
 Resource utilization: high efficiency and density.

Why you need Kubernetes and what it can do 
 container goes down, another container needs to start. Wouldn't it be easier if this behavior was handled by a system?
 Service discovery and load balancing
 Storage orchestration Kubernetes allows you to automatically mount a storage system of your choice, such as local storages, public cloud providers, and more.
 Automated rollouts and rollbacks
 Automatic bin packing You tell Kubernetes how much CPU and memory (RAM) each container needs. Kubernetes can fit containers onto your nodes to make the best use of your resources.
 Self-healing Kubernetes restarts containers that fail, replaces containers, kills containers that don't respond to your user-defined health check,
 and doesn't advertise them to clients until they are ready to serve.
 Secret and configuration management Kubernetes lets you store and manage sensitive information,

What Kubernetes is not
 Kubernetes is not a traditional, all-inclusive PaaS (Platform as a Service) system. Since Kubernetes operates at the container level rather than at the hardware level,

Kubernetes Components
 ![Kubernetes Components](images/components-of-kubernetes.svg)

kube-apiserver is designed to scale horizontally—that is, it scales by deploying more instances. You can run several instances of kube-apiserver and balance traffic between those instances.
etcd Consistent and highly-available key value store used as Kubernetes' backing store for all cluster data.

kube-scheduler
Control plane component that watches for newly created Pods with no assigned node, and selects a node for them to run on.

kube-controller-manager
 Tyopes of node controller
  Node controller: Responsible for noticing and responding when nodes go down.
  Job controller: Watches for Job objects that represent one-off tasks, then creates Pods to run those tasks to completion.
  Endpoints controller: Populates the Endpoints object (that is, joins Services & Pods).
  Service Account & Token controllers: Create default accounts and API access tokens for new namespaces.

Node Components
 kubelet -> An agent that runs on each node in the cluster. It makes sure that containers are running in a Pod.

kube-proxy 
 kube-proxy is a network proxy that runs on each node in your cluster, implementing part of the Kubernetes Service concept.

 kube-proxy maintains network rules on nodes. These network rules allow network communication to your Pods from network sessions inside or outside of your cluster.

Addons
 Addons use Kubernetes resources (DaemonSet, Deployment, etc) to implement cluster features

The Kubernetes API
 The core of Kubernetes' control plane is the API server. The API server exposes an HTTP API that lets end users, different parts of your cluster,
 and external components communicate with one another

Understanding Kubernetes Objects
 Kubernetes objects are persistent entities in the Kubernetes system. Kubernetes uses these entities to represent the state of your cluster.

Kubernetes object descirbe below
  What containerized applications are running (and on which nodes)
  The resources available to those applications
  The policies around how those applications behave, such as restart policies, upgrades, and fault-tolerance

apiVersion - Which version of the Kubernetes API you're using to create this object
kind - What kind of object you want to create
metadata - Data that helps uniquely identify the object, including a name string, UID, and optional namespace
spec - What state you desire for the object

Imperative commands	Live objects	Development projects	1+	Lowest
Imperative object configuration	Individual files	Production projects	1	Moderate
Declarative object configuration	Directories of files	Production projects	1+	Highest

Object Names and IDs
Each object in your cluster has a Name that is unique for that type of resource. Every Kubernetes object also has a UID that is unique across your whole cluster.
For non-unique user-provided attributes, Kubernetes provides labels and annotations.

Namespaces
In Kubernetes, namespaces provides a mechanism for isolating groups of resources within a single cluster.
Names of resources need to be unique within a namespace, but not across namespaces.
Namespace-based scoping is applicable only for namespaced objects (e.g. Deployments, Services, etc) and not for cluster-wide objects (e.g. StorageClass, Nodes, PersistentVolumes, etc).

Namespaces are intended for use in environments with many users spread across multiple teams, or projects.

Namespace:
 default
 kube-system
 kube-public
 kube-node-lease

Namespaces and DNS
 <service-name>.<namespace-name>.svc.cluster.local

Not All Objects are in a Namespace
# In a namespace
kubectl api-resources --namespaced=true

# Not in a namespace
kubectl api-resources --namespaced=false

Labels and Selectors
Labels are key/value pairs that are attached to objects, such as pods. Labels are intended to be used to specify identifying attributes of objects that are meaningful and relevant to users,

Example labels:

"release" : "stable", "release" : "canary"
"environment" : "dev", "environment" : "qa", "environment" : "production"
"tier" : "frontend", "tier" : "backend", "tier" : "cache"
"partition" : "customerA", "partition" : "customerB"
"track" : "daily", "track" : "weekly"

Label selectors 
Unlike names and UIDs, labels do not provide uniqueness. In general, we expect many objects to carry the same label(s).

Equality-based requirement
environment = production
tier != frontend

Set-based requirement
environment in (production, qa)
tier notin (frontend, backend)
partition
!partition

Set-based requirements can be mixed with equality-based requirements. For example: partition in (customerA, customerB),environment!=qa.

kubectl get pods -l 'environment in (production),tier in (frontend)'

Resources that support set-based requirements 
Newer resources, such as Job, Deployment, ReplicaSet, and DaemonSet, support set-based requirements as well.

selector:
  matchLabels:
    component: redis
  matchExpressions:
    - {key: tier, operator: In, values: [cache]}
    - {key: environment, operator: NotIn, values: [dev]}

Annotations
You can use Kubernetes annotations to attach arbitrary non-identifying metadata to objects. Clients such as tools and libraries can retrieve this metadata.

Annotations, like labels, are key/value maps:

"metadata": {
  "annotations": {
    "key1" : "value1",
    "key2" : "value2"
  }
}

Filed Selectors
kubectl get pods --field-selector=status.phase!=Running,spec.restartPolicy=Always

Chained selectors -> kubectl get pods --field-selector status.phase=Running,metadata.namespace=default

Multiple resource type -> kubectl get svc,replicaset --all-namespaces --field-selector metadata.namespace!=default

Finalizers
Finalizers are namespaced keys that tell Kubernetes to wait until specific conditions are met before it fully deletes resources marked for deletion.
Finalizers alert controllers to clean up resources the deleted object owned.

Owners and Dependents
In Kubernetes, some objects are owners of other objects. For example, a ReplicaSet is the owner of a set of Pods.

Recommended Labels
# This is an excerpt
apiVersion: apps/v1
kind: StatefulSet
metadata:
  labels:
    app.kubernetes.io/name: mysql
    app.kubernetes.io/instance: mysql-abcxzy
    app.kubernetes.io/version: "5.7.21"
    app.kubernetes.io/component: database
    app.kubernetes.io/part-of: wordpress
    app.kubernetes.io/managed-by: helm

Workloads
=========

Pods
Pods are the smallest deployable units of computing that you can create and manage in Kubernetes.

The shared context of a Pod is a set of Linux namespaces, cgroups, and potentially other facets of isolation - the same things that isolate a container.
Within a Pod's context, the individual applications may have further sub-isolations applied.

Pods in a Kubernetes cluster are used in two main ways:
  Pods that run a single container. The "one-container-per-Pod" model is the most common Kubernetes use case;
  in this case, you can think of a Pod as a wrapper around a single container; Kubernetes manages Pods rather than managing the containers directly.
  Pods that run multiple containers that need to work together.

Pod life cycle
 prestart and poststop
 allocatiing network, probe dignostic
 success,failure, failure

Also, init containers do not support lifecycle, livenessProbe, readinessProbe, or startupProbe

kubectl rollout status deployment/simpleapp
kubectl rollout history deployment/simpleapp
kubectl rollout undo deployment/simpleapp
kubectl scale deployment/simpleapp --replicas=10

Deployments
A Deployment provides declarative updates for Pods and ReplicaSets.

ReplicaSet
A ReplicaSet's purpose is to maintain a stable set of replica Pods running at any given time. As such, it is often used to guarantee the availability of a specified number of identical Pods.

Avoid using replicaset and use deplyment instead of replicaset

StatefulSets
StatefulSet is the workload API object used to manage stateful applications.

Manages the deployment and scaling of a set of Pods, and provides guarantees about the ordering and uniqueness of these Pods.

Deployment or ReplicaSet may be better suited to your stateless needs.

CronJob
FEATURE STATE: Kubernetes v1.21 [stable]
A CronJob creates Jobs on a repeating schedule.

ReplicationController
Note: A Deployment that configures a ReplicaSet is now the recommended way to set up replication.
A ReplicationController ensures that a specified number of pod replicas are running at any one time. In other words,
a ReplicationController makes sure that a pod or a homogeneous set of pods is always up and available.








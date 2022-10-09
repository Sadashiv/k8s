Nodes
Kubernetes runs your workload by placing containers into Pods to run on Nodes. A node may be a virtual or physical machine, depending on the cluster.
Each node is managed by the control plane and contains the services necessary to run Pods.

Two ways to add node
 The kubelet on a node self-registers to the control plane
 You (or another human user) manually add a Node object

{
  "kind": "Node",
  "apiVersion": "v1",
  "metadata": {
    "name": "10.240.79.157",
    "labels": {
      "name": "my-first-k8s-node"
    }
  }
}

To mark a Node unschedulable, run:
kubectl cordon $NODENAME

Node controller
The node controller is a Kubernetes control plane component that manages various aspects of nodes.

The node controller has multiple roles in a node's life. The first is assigning a CIDR block to the node when it is registered (if CIDR assignment is turned on).
If noe i not availble we make Non Graceful node shutdown 

What is cgroup v2?
FEATURE STATE: Kubernetes v1.25 [stable]
cgroup v2 is the next version of the Linux cgroup API. cgroup v2 provides a unified control system with enhanced resource management capabilities.

Identify the cgroup version on Linux Nodes
The cgroup version depends on on the Linux distribution being used and the default cgroup version configured on the OS. To check which cgroup version your distribution uses, run the stat -fc %T /sys/fs/cgroup/ command on the node:

stat -fc %T /sys/fs/cgroup/
For cgroup v2, the output is cgroup2fs.

For cgroup v1, the output is tmpfs.

Garbage Collection
Garbage collection is a collective term for the various mechanisms Kubernetes uses to clean up cluster resources. This allows the clean up of resources like the following:

Terminated pods
Completed Jobs
Objects without owner references
Unused containers and container images
Dynamically provisioned PersistentVolumes with a StorageClass reclaim policy of Delete
Stale or expired CertificateSigningRequests (CSRs)
Nodes deleted in the following scenarios:
On a cloud when the cluster uses a cloud controller manager
On-premises when the cluster uses an addon similar to a cloud controller manager
Node Lease objects


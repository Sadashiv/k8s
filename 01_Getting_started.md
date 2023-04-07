k8s can get from cloud

cluster full details
 No more than 110 pods per node
 No more than 5000 nodes
 No more than 150000 total pods
 No more than 300000 total containers

Addon resources 
 Kubernetes resource limits help to minimize the impact of memory leaks and other ways that pods and containers can impact on other components

   containers:
  - name: fluentd-cloud-logging
    image: fluent/fluentd-kubernetes-daemonset:v1
    resources:
      limits:
        cpu: 100m
        memory: 200Mi

 Some addons scale vertically - there is one replica of the addon for the cluster or serving a whole failure zone.
 Many addons scale horizontally - you add capacity by running more pods - but with a very large cluster you may also need to raise CPU or memory limits slightly. 
 Some addons run as one copy per node, controlled by a DaemonSet: for example, a node-level log aggregator. 
 VerticalPodAutoscaler is a custom resource that you can deploy into your cluster to help you manage resource requests and limits for pods.

Running in multiple zones
 Control plane behavior 
 All control plane components support running as a pool of interchangeable resources, replicated per component.

Node behavior 
 Kubernetes automatically spreads the Pods for workload resources (such as Deployment or StatefulSet) across different nodes in a cluster.
 This spreading helps reduce the impact of failures.

Autoscale nodes: Most cloud providers support Cluster Autoscaler to replace unhealthy nodes or grow and shrink the number of nodes as demand requires.

Validate node setup
Node Conformance Test
Node conformance test is a containerized test framework that provides a system verification and functionality test for a node. The test validates whether the node meets the minimum requirements for Kubernetes; a node that passes the test is qualified to join a Kubernetes cluster.

Node Prerequisite
 To run node conformance test following daemons installed:
 Container Runtime (Docker)
 Kubelet

 Running Node Conformance Test
 # $CONFIG_DIR is the pod manifest path of your Kubelet.
 # $LOG_DIR is the test output path.
 sudo docker run -it --rm --privileged --net=host \
  -v /:/rootfs -v $CONFIG_DIR:$CONFIG_DIR -v $LOG_DIR:/var/result \
  registry.k8s.io/node-test:0.2
  Node conformance test is a containerized version of node e2e test. By default, it runs all conformance tests.

Enforcing Pod Security Standards
 This page provides an overview of best practices when it comes to enforcing Pod Security Standards.

 Using the built-in Pod Security Admission Controller

PKI certificates and requirements
 A PKI(Public Key Infrastructure) certificate is a trusted digital identity. It is used to identify users,
 servers or things when communicating over untrusted networks, to sign code or documents and to encrypt data or communication.
 A PKI certificate is also called a digital certificate.

 Kubernetes requires PKI certificates for authentication over TLS. If you install Kubernetes with kubeadm, 
 Where certificates are stored
 If you install Kubernetes with kubeadm, most certificates are stored in /etc/kubernetes/pki.
 Configure certificates manually
 If you don't want kubeadm to generate the required certificates
 Configure certificates for user accounts -> Yes


Container Runtime
 Dockershim has been removed from the Kubernetes project as of release 1.24. Read the Dockershim Removal FAQ for further details.
 Kubernetes 1.25 requires that you use a runtime that conforms with the Container Runtime Interface (CRI).

Install and configure prerequisites
 lsmod | grep br_netfilter

 cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

# sysctl params required by setup, params persist across reboots
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

# Apply sysctl params without reboot
sudo sysctl --system

Cgroup drivers
 There are two cgroup drivers available:
 cgroupfs
 systemd

cgroupfs driver
 The cgroupfs driver is the default cgroup driver in the kubelet.


The cgroupfs driver is not recommended when systemd is the init system because systemd expects a single cgroup manager on the system.
Additionally, if you use cgroup v2 , use the systemd cgroup driver instead of cgroupfs.

cgroupDriver: systemd

Migrating to the systemd driver in kubeadm managed clusters
If you wish to migrate to the systemd cgroup driver in existing kubeadm managed clusters, follow configuring a cgroup driver.

containerd 
 /etc/containerd/config.toml



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




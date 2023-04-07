#Installing k8s with kubespray or kops in AWS
#Kubespray is a composition of Ansible playbooks, inventory, provisioning tools, 
#Installinf k8s with kubeadm

#No more than 110 pods per node
#No more than 5,000 nodes
#No more than 150,000 total pods
#No more than 300,000 total containers

#!/bin/bash
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

lsmod | grep br_netfilter
lsmod | grep overlay
sysctl net.bridge.bridge-nf-call-iptables net.bridge.bridge-nf-call-ip6tables net.ipv4.ip_forward

#Install kubectl
sudo apt-get update
sudo apt-get install -y ca-certificates curl
sudo apt-get install -y apt-transport-https
sudo curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl
udo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
kubectl version

mkdir $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

#Auto completion
#echo 'source <(kubectl completion bash)' >>~/.bashrc
#echo 'alias k=kubectl' >>~/.bashrc
#echo 'complete -o default -F __start_kubectl k' >>~/.bashrc
#source ~/.bashrc

#Configuring a cgroup driver 
#sudo kubeadm init --pod-network-cidr

#To view the token
#kubeadm token list
#remove node
#kubectl drain <node name> --delete-emptydir-data --force --ignore-daemonsets

#To deploy pod in the master
#kubectl taint nodes --all node-role.kubernetes.io/control-plane-

#Upgrade kubectl kubeadm and kubelet to latest version
#sudo apt-get upgrade kubectl kubeadm kubelet

#kubeadm config images list
#kubeadm init --service-cidr 10.96.0.0/12

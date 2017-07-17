systemctl stop kubelet
systemctl stop docker
iptables --flush
iptables -tnat --flush
systemctl start kubelet
systemctl start docker

minikube stop
minikube delete
minikube start --vm-driver=none

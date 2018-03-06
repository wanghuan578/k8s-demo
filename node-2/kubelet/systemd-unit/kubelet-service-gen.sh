#!/bin/bash
mkdir /var/lib/kubelet # 必须先创建工作目录
cat > kubelet.service <<EOF
[Unit]
Description=Kubernetes Kubelet
Documentation=https://github.com/GoogleCloudPlatform/kubernetes
After=docker.service
Requires=docker.service
[Service]
WorkingDirectory=/var/lib/kubelet
ExecStart=/usr/bin/kubelet \\
--address=${NODE_IP} \\
--hostname-override=${NODE_IP} \\
--pod-infra-container-image=registry.access.redhat.com/rhel7/pod-infrastructure:latest \\
--experimental-bootstrap-kubeconfig=/etc/kubernetes/bootstrap.kubeconfig \\
--kubeconfig=/etc/kubernetes/kubelet.kubeconfig \\
--require-kubeconfig \\
--cert-dir=/etc/kubernetes/ssl \\
--cluster-dns=${CLUSTER_DNS_SVC_IP} \\
--cluster-domain=${CLUSTER_DNS_DOMAIN} \\
--hairpin-mode promiscuous-bridge \\
--allow-privileged=true \\
--serialize-image-pulls=false \\
--logtostderr=true \\
--v=2
#ExecStartPost=/sbin/iptables -A INPUT -s 172.30.0.0/12 -p tcp --dport 4194 -j ACCEPT
#ExecStartPost=/sbin/iptables -A INPUT -s 192.168.0.0/16 -p tcp --dport 4194 -j ACCEPT
#ExecStartPost=/sbin/iptables -A INPUT -p tcp --dport 4194 -j DROP
Restart=on-failure
RestartSec=5
[Install]
WantedBy=multi-user.target
EOF

mv kubelet.service /etc/systemd/system/kubelet.service
systemctl daemon-reload
systemctl enable kubelet
systemctl start kubelet
systemctl status kubelet

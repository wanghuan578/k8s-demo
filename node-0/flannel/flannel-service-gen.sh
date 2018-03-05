#!/bin/bash
cat > flanneld.service << EOF
[Unit]
Description=Flanneld overlay address etcd agent
After=network.target
After=network-online.target
Wants=network-online.target
After=etcd.service
Before=docker.service
[Service]
Type=notify
ExecStart=/usr/bin/flanneld \\
--name=$ETCD_ENDPOINTS \\
-etcd-cafile=/etc/kubernetes/ssl/ca.pem \\
-etcd-certfile=/etc/flanneld/ssl/flanneld.pem \\
-etcd-keyfile=/etc/flanneld/ssl/flanneld-key.pem \\
-etcd-endpoints=$ETCD_ENDPOINTS \\
-etcd-prefix=$FLANNEL_ETCD_PREFIX
ExecStartPost=/usr/bin/mk-docker-opts.sh -k DOCKER_NETWOR
K_OPTIONS -d /run/flannel/docker
Restart=on-failure
[Install]
WantedBy=multi-user.target
RequiredBy=docker.service
EOF
#cp flanneld.service /etc/systemd/system/
#systemctl daemon-reload
#systemctl enable flanneld
#systemctl start flanneld
#systemctl status flanneld

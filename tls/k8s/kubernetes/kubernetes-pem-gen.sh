#!/bin/bash
cat > kubernetes-csr.json <<EOF
{
"CN": "kubernetes",
"hosts": [
"127.0.0.1",
"${MASTER_IP}",
"${CLUSTER_KUBERNETES_SVC_IP}",
"kubernetes",
"kubernetes.default",
"kubernetes.default.svc",
"kubernetes.default.svc.cluster",
"kubernetes.default.svc.cluster.local"
],
"key": {
"algo": "rsa",
"size": 2048
},
"names": [
{
"C": "CN",
"ST": "BeiJing",
"L": "BeiJing",
"O": "k8s",
"OU": "System"
}
]
}
EOF

cfssl gencert \
-ca=/etc/kubernetes/ssl/ca.pem \
-ca-key=/etc/kubernetes/ssl/ca-key.pem \
-config=/etc/kubernetes/ssl/ca-config.json \
-profile=kubernetes kubernetes-csr.json | cfssljson -bare kubernetes

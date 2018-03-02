#!/bin/bash

./flanneld-csr-gen.sh

cfssl gencert -ca=/etc/kubernetes/ssl/ca.pem \
-ca-key=/etc/kubernetes/ssl/ca-key.pem \
-config=/etc/kubernetes/ssl/ca-config.json \
-profile=kubernetes flanneld-csr.json | cfssljson -bare flanneld

mkdir /etc/flanneld/ssl -p
mv flanneld*.pem /etc/flanneld/ssl
rm flanneld.csr flanneld-csr.json

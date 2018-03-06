#!/bin/bash
systemctl daemon-reload
systemctl stop firewalld
systemctl disable firewalld
iptables -F && iptables -X && iptables -F -t nat && iptables -X -t nat
systemctl enable docker
systemctl start docker

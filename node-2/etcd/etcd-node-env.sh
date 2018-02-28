#!/bin/bash

# 当前部署的机器名称(随便定义，只要能区分不同机器即可)
export NODE_NAME=etcd-host2

# 当前部署的机器 IP
export NODE_IP=192.168.207.131

# etcd 集群所有机器 IP
export NODE_IPS="192.168.207.128 192.168.207.129 192.168.207.131"

# etcd 集群间通信的IP和端口
export ETCD_NODES=etcd-host0=https://192.168.207.128:2380,etcd-host1=https://192.168.207.129:2380,etcd-host2=https://192.168.207.131:2380

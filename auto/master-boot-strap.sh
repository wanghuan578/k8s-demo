#!/bin/bash
systemctl daemon-reload
systemctl enable kube-apiserver
systemctl start kube-apiserver
systemctl enable kube-controller-manager
systemctl start kube-controller-manager
systemctl enable kube-scheduler
systemctl start kube-scheduler

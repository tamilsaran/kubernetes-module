#!/bin/bash
sleep 2m
joinCommand=$(kubeadm token create --print-join-command)
echo "$joinCommand --ignore-preflight-errors=Swap,FileContent--proc-sys-net-bridge-bridge-nf-call-iptables,SystemVerification" > /home/zippyops/joincluster.sh



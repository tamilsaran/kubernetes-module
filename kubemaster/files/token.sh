 joinCommand=$(kubeadm token create --print-join-command)
 echo "$joinCommand --ignore-preflight-errors=Swap,FileContent--proc-sys-net-bridge-bridge-nf-call-iptables,SystemVerification" > /root/joincluster.sh


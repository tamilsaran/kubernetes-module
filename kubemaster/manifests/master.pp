# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include kubemaster::master
class kubemaster::master {
if $::osfamily == 'RedHat'
{
exec {'master_install':
command => 'kubeadm init --pod-network-cidr=10.244.0.0/16 --ignore-preflight-errors=Swap,FileContent--proc-sys-net-bridge-bridge-nf-call-iptables,SystemVerification >> /root/kubeinit.log 2>&1',
path     => $::path
}
exec { 'kube_directory':
command => 'mkdir /root/.kube',
path    => $::path
}
exec { 'copy_file':
command => 'cp /etc/kubernetes/admin.conf /root/.kube/config',
path    => $::path
}

exec {'fannel':
command => 'kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml > /dev/null 2>&1',
path    => $::path
}
file { "/root/token.sh":
      mode   => "0777",
      owner  => 'root',
      group  => 'root',
      source => 'puppet:///modules/kubemaster/token.sh',
      notify =>  Exec['/root/token.sh'],
}
exec {'/root/token.sh':
}
}

if $::osfamily == 'Debian'
{
exec {'ubunutumaster_install':
  command => 'sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --ignore-preflight-errors=Swap,FileContent--proc-sys-net-bridge-bridge-nf-call-iptables,SystemVerification >> /root/kubeinit.log 2>&1',
  path => $::path
}
exec {'ubnutukube':
command => 'mkdir /root/.kube',
  path => $::path
}
exec {'ubuntuconfig':
command => 'cp /etc/kubernetes/admin.conf  /root/.kube/config',
  path => $::path
}
exec {'ubuntufannel':
  command => 'sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml',
  path => $::path
}
file { "/home/zippyops/utoken.sh":
      mode   => "0777",
      owner  => 'zippyops',
      group  => 'zippyops',
      source => 'puppet:///modules/kubemaster/utoken.sh',
      notify => Exec['/home/zippyops/utoken.sh'],
}
exec {'/home/zippyops/utoken.sh':
}
}
}






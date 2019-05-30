# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include kubemaster::install
class kubemaster::install {
if $::osfamily == 'RedHat'
{
exec { 'swapoff':
command => 'swapoff -a',
path    => $::path
}

exec { 'Install docker container engine':
command => 'yum install -y -q yum-utils device-mapper-persistent-data lvm2 > /dev/null 2>&1',
path    => $::path
}
exec { 'docker_repo':
command => 'yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo > /dev/null 2>&1',
path    => $::path
}
exec { 'docker_install':
command => 'yum install -y -q docker-ce-18.06.0.ce-3.el7 >/dev/null 2>&1',
path    => $::path
}
exec {'Enable and start docker service':
command => 'systemctl enable docker >/dev/null 2>&1',
path    => $::path
}
exec {'start_docker':

command => 'systemctl start docker',
path    => $::path
}
file { "/etc/yum.repos.d/kubernetes.repo":
       mode   => "0777",
       owner  => 'root',
       group  => 'root',
       source => 'puppet:///modules/kubemaster/kubernetes.repo',
}
exec { 'Install Kubernetes (kubeadm, kubelet and kubectl)':
command => 'yum install -y -q kubeadm kubelet kubectl >/dev/null 2>&1',
path    => $::path
}
exec { 'Enable and start kubelet service':
command => 'systemctl enable kubelet >/dev/null 2>&1',
path    => $::path
}
exec { 'echo_kubelet':
command => 'echo "KUBELET_EXTRA_ARGS="--fail-swap-on=false"" > /etc/sysconfig/kubelet',
path    => $::path
}
exec { 'start_kubelet':
command => 'systemctl start kubelet >/dev/null 2>&1',
path    => $::path
}
exec {'install Openssh server':
command => 'yum install -y -q openssh-server >/dev/null 2>&1',
path    => $::path
}
exec {'enable_sshd':

command => 'systemctl enable sshd >/dev/null 2>&1',
path    => $::path

}
exec {'start_sshd':

command => 'systemctl start sshd >/dev/null 2>&1',
path    => $::path

}
exec {'other package':
command => 'yum install -y -q which net-tools sudo sshpass less >/dev/null 2>&1',
path    => $::path  
}
}




if $::osfamily == 'Debian'
{
exec {'Install docker container engine':
    command => 'sudo swapoff -a',
       path => $::path,
}

exec { 'docker':
  command => 'sudo apt install -y docker.io',
     path => $::path
}
exec { 'dockerenable':
  command => 'sudo systemctl enable docker',
   path => $::path
}
exec { 'dockerstart':
  command => 'sudo systemctl start docker',
  path => $::path
}
exec {'Enable and start docker service':
    command => 'curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add',
  path => $::path
}

exec { 'curl':
  command => 'sudo apt install -y curl',
  path => $::path
}
exec {'repo':
command => 'sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"',
  path => $::path
}
exec { 'kubeadm':
  command => 'sudo apt install -y kubeadm',
  path => $::path
}
exec {'ubuntu install Openssh server':
    command => 'sudo apt install -y openssh-server',
  path => $::path
}
exec { 'sshd enable':
  command => 'sudo systemctl enable sshd',
  path => $::path
}
exec { 'sshdstart':
  command => 'sudo systemctl start sshd',
  path => $::path
}


}

}

# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include kubeworker::worker
class kubeworker::worker {
if $::osfamily == 'RedHat'
{
exec {'worker-install':
command =>  'echo "1" /proc/sys/net/bridge/bridge-nf-call-iptables',
path    => $::path,
}
exec { 'ssh&scp_file':
command => 'sshpass -p "zippyops" scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no 192.168.1.180:/root/joincluster.sh /root/joincluster.sh 2>/tmp/joincluster.log',
path    => $::path,
}
exec { 'chmode':
command => 'sleep 10 && chmod 777 joincluster.sh',
path    => $::path,
}
exec { '/root/joincluster.sh':
}
}





if $::osfamily == 'Debian'
{
exec {'worker-install':
command => 'sudo apt-get install -y sshpass',
path    => $path,
}
exec { 'iptable':
command => 'echo "1" /proc/sys/net/bridge/bridge-nf-call-iptables',
path    => $path,
}
exec { 'ssh':
command => 'sshpass -p "zippyops" scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no zippyops@192.168.1.182:/home/zippyops/joincluster.sh /home/zippyops',
path    => $path,
}
exec { 'changemode':
command => 'sleep 10 && chmod 777 joincluster.sh',
path    => $path,
}
exec { '/home/zippyops/joincluster.sh':
}

}
}

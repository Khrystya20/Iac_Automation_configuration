[primary]
${primary_ip} ansible_user=ubuntu ansible_ssh_private_key_file=${ssh_key_path} private_primary_ip=${private_primary_ip} ansible_ssh_common_args='-o StrictHostKeyChecking=no'

[replica]
${replica_ip} ansible_user=ubuntu ansible_ssh_private_key_file=${ssh_key_path} private_replica_ip=${private_replica_ip} ansible_ssh_common_args='-o StrictHostKeyChecking=no'

[all_servers]
%{ for server in server_ips }
${server}
%{ endfor }

[all:vars]
ansible_python_interpreter=/usr/bin/python3
primary_server_ip=${primary_ip}
private_primary_ip=${private_primary_ip}
replica_server_ip=${replica_ip}
private_replica_ip=${private_replica_ip}
ansible_ssh_public_key="${ssh_public_key}"
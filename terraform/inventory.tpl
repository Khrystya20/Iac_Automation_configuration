[primary]
${primary_ip} ansible_user=ubuntu ansible_ssh_private_key_file=${ssh_key_path}

[replica]
${replica_ip} ansible_user=ubuntu ansible_ssh_private_key_file=${ssh_key_path}

[all_servers]
%{ for server in server_ips }
${server}
%{ endfor }

[all:vars]
ansible_python_interpreter=/usr/bin/python3
primary_server_ip=${primary_ip}
replica_server_ip=${replica_ip}
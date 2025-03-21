resource "local_file" "ansible_inventory" {
  depends_on = [aws_instance.servers]

  content  = templatefile("${path.module}/inventory.tpl", {
    primary_ip = aws_instance.servers[0].public_ip
    private_primary_ip = aws_instance.servers[0].private_ip
    replica_ip = aws_instance.servers[1].public_ip
    private_replica_ip = aws_instance.servers[1].private_ip
    server_ips = [aws_instance.servers[0].public_ip, aws_instance.servers[1].public_ip]
    ssh_key_path  = var.ssh_private_key_path
    ssh_public_key = var.public_ssh_keys[0]
  })

  filename = "${path.module}/../ansible/inventory.ini"
}
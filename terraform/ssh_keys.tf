resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = var.public_ssh_keys[0]
}

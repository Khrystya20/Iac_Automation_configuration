variable "server_count" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 2
}

variable "aws_region" {
  description = "AWS region where instances will be created"
  type        = string
  default = "eu-central-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default = "t2.micro"
}

variable "key_name" {
  description = "Name of the AWS Key Pair for SSH access"
  type        = string
  default     = "boiko-khr-key"
}

variable "ssh_private_key_path" {
  description = "Path to SSH private key"
  type        = string
  default     = "~/.ssh/boiko-key"
}

variable "public_ssh_keys" {
  description = "List of public SSH keys allowed for SSH access"
  type        = list(string)
  default = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCfSKU+x1ODicj9wluvx0pDM/vYyvnxRQcgFEV+HzQ4ODR5I2Rgs+tA072cIMgUK0KTWKMwO8KOEubdGAHAB6eeGGos4bjYfNfnnHtFTOfgNl5E0GRhifL8YylOS65XHkUe6wQWd7pIaWARPniM5w2spknRmh0JiRk9KS506qEk6J1Jo/q+KofiTmHQu8wyOTbEmg49C5x6lPmYu/kWo0cYR85YY0P/m0h+9Y8bMkXop4HrwBJrcJ3+UrJE38Bt1sdYcVQUbbKqnOguHUNwjRAQ4ITuZbbV6OfR+DLwxWcxyl/Yfh+QkZFpmrqWZREAUg6VphO6h1+voRkGGHNUolPLPHhgOgeFiWV+0/0MaYnFACgveJZ8UaUMEbD/3mrv4+qwvpvmIBCTBgJ/pgq6/tayxcIgbz4mX4VBSG8vOAQuui6HjN0gHyyrmFdzW6Hi5JhMYkXqPGHfQK8Y9eWbWYf/Kn3xyriD6M3a2HlCZM2U9d64vlm4RRU/FsRP2hNZRLD74mREUC66iiV2PRzwx4d46gByOV+1s+tK83tNjX24eyBVQ8xroqJu247oPS7XlzEJN/h+dtgPn4uiSfCe1k+4ElsPUyznlMQt/Bq6/7C9YU7ywEC+e4sdzOHpCJyZJg/OAuRVQ8xX/b9rTDMUKEUnoXmplWoNiPIccxt+bP4Hbw== kh.boiko@ukma.edu.ua",
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOkAhvfRyUvgsUwENIds1a/4OvuHQgLki8K1EzPltl5M i.ilin@iilin-pro14.local"
  ]
}

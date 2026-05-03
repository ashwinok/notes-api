variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "project" {
  description = "Project name used for tagging"
  type        = string
  default     = "notes-api"
}

variable "ssh_public_key_path" {
  description = "Path to your local SSH public key"
  type        = string
  default     = "~/.ssh/notes-api-terraform.pub"
}

variable "my_ip_cidr" {
  description = "Your public IP in CIDR form, used to restrict SSH access"
  type        = string
}

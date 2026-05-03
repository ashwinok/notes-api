output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.this.public_ip
}

output "ssh_command" {
  description = "Convenience command to SSH into the instance"
  value       = "ssh ubuntu@${aws_instance.this.public_ip}"
}

output "app_url" {
  description = "URL where the app will be reachable once deployed"
  value       = "http://${aws_instance.this.public_ip}:8000"
}

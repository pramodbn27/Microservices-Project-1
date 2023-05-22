output "master_public_ip" {
  description = "List of public IP addresses assigned to the Master Node, if applicable"
  value       = aws_instance.node.public_ip
}
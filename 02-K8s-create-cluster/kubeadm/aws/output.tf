output "master_public_ip" {
  description = "List of public IP addresses assigned to the Master Node, if applicable"
  value       = aws_instance.master.public_ip
}

output "woker_node_public_ip" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = ["${aws_instance.worker.*.public_ip}"]
}

# output "private_key" {
#     value = module.key_pair.private_key_pem
#     sensitive = true
  
# }
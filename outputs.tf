output "public_ip" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = "${module.hab-instance.public_ip}"
}

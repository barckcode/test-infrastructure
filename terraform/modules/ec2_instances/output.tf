output "instancia_ids" {
  description = "IDs de las instancias"
  value       = [for server in aws_instance.server : server.id]
}

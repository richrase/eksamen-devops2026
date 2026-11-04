output "service_url" {
  description = "Offentlig URL til tjenesten"
  value       = "https://${aws_ecs_express_gateway_service.app.ingress_paths[0].endpoint}"
}

output "service_arn" {
  value = aws_ecs_express_gateway_service.app.service_arn
}

output "s3_bucket" {
  value = aws_s3_bucket.images.bucket
}

output "task_role_arn" {
  value = aws_iam_role.task.arn
}

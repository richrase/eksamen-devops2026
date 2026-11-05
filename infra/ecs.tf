locals {
  service_name = "wishifai-${var.candidate}"
}

resource "aws_cloudwatch_log_group" "app" {
  name              = "/ecs/${local.service_name}"
  retention_in_days = 14
}

resource "aws_ecs_express_gateway_service" "app" {
  service_name            = local.service_name
  execution_role_arn      = var.execution_role_arn
  infrastructure_role_arn = var.infrastructure_role_arn
  task_role_arn           = aws_iam_role.task.arn

  cpu               = "1024"
  memory            = "2048"
  health_check_path = "/actuator/health"

  primary_container {
    image          = "${var.ecr_repository}:${var.image_tag}"
    container_port = 8080

    environment {
      name  = "S3_BUCKET"
      value = aws_s3_bucket.images.bucket
    }

    aws_logs_configuration {
      log_group         = aws_cloudwatch_log_group.app.name
      log_stream_prefix = "app"
    }
  }

  depends_on = [aws_iam_role_policy.task]
}

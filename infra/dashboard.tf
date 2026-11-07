locals {
  metrics_namespace = "wishifai-${var.candidate}"
  # ECS Express legger tjenesten i default-clusteret
  ecs_cluster_name = "default"
}

resource "aws_cloudwatch_dashboard" "app" {
  dashboard_name = "wishifai-${var.candidate}"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6
        properties = {
          title  = "Business: gaveforslag generert"
          region = var.region
          view   = "timeSeries"
          stat   = "Sum"
          period = 60
          metrics = [
            [local.metrics_namespace, "wishifai.gifts.suggested.count"]
          ]
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6
        properties = {
          title  = "Applikasjon: responstid Bedrock vs Rekognition (ms)"
          region = var.region
          view   = "timeSeries"
          stat   = "Maximum"
          period = 60
          metrics = [
            [local.metrics_namespace, "bedrock.converse.time.max", { label = "Bedrock max" }],
            [local.metrics_namespace, "rekognition.detect.time.max", { label = "Rekognition max" }]
          ]
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 6
        width  = 12
        height = 6
        properties = {
          title  = "Applikasjon: JVM-tråder og live data size"
          region = var.region
          view   = "timeSeries"
          stat   = "Average"
          period = 60
          metrics = [
            [local.metrics_namespace, "jvm.threads.live.value", { label = "Live tråder" }],
            [local.metrics_namespace, "jvm.gc.live.data.size.value", { label = "GC live data (bytes)", yAxis = "right" }]
          ]
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 6
        width  = 12
        height = 6
        properties = {
          title  = "Infrastruktur: ECS CPU og minne (%)"
          region = var.region
          view   = "timeSeries"
          stat   = "Average"
          period = 60
          metrics = [
            ["AWS/ECS", "CPUUtilization", "ClusterName", local.ecs_cluster_name, "ServiceName", local.service_name],
            ["AWS/ECS", "MemoryUtilization", "ClusterName", local.ecs_cluster_name, "ServiceName", local.service_name]
          ]
        }
      }
    ]
  })
}

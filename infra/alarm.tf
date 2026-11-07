resource "aws_cloudwatch_metric_alarm" "bedrock_slow" {
  alarm_name          = "wishifai-${var.candidate}-bedrock-slow"
  alarm_description   = "Gjennomsnittlig Bedrock-kall har vaert over 15 s i 3 av 3 minutter"
  namespace           = local.metrics_namespace
  metric_name         = "bedrock.converse.time.avg"
  statistic           = "Average"
  period              = 60
  evaluation_periods  = 3
  datapoints_to_alarm = 3
  threshold           = 15000
  comparison_operator = "GreaterThanThreshold"
  treat_missing_data  = "notBreaching"
}
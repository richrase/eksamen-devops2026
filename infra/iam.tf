data "aws_iam_policy_document" "task_assume" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "task" {
  name               = "wishifai-task-role-${var.candidate}"
  assume_role_policy = data.aws_iam_policy_document.task_assume.json
}

data "aws_iam_policy_document" "task_permissions" {
  statement {
    sid       = "S3Images"
    actions   = ["s3:PutObject"]
    resources = [aws_s3_bucket.images.arn, "${aws_s3_bucket.images.arn}/*"]
  }

  statement {
    sid       = "Rekognition"
    actions   = ["rekognition:DetectLabels"]
    resources = ["*"]
  }

  statement {
    sid       = "Bedrock"
    actions   = ["bedrock:InvokeModel"]
    resources = ["*"]
  }

  # Brukes av Micrometer CloudWatch-registry i oppgave 3
  statement {
    sid       = "CloudWatchMetrics"
    actions   = ["cloudwatch:PutMetricData"]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "task" {
  name   = "wishifai-task-policy-${var.candidate}"
  role   = aws_iam_role.task.id
  policy = data.aws_iam_policy_document.task_permissions.json
}

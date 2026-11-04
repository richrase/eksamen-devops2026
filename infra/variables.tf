variable "region" {
  description = "AWS-region"
  type        = string
  default     = "eu-west-1"
}

variable "candidate" {
  description = "Kandidatnummer"
  type        = string
}

variable "image_tag" {
  description = "Tag på imaget i ECR (kort commit-SHA fra pipelinen)"
  type        = string
}

variable "ecr_repository" {
  description = "ECR-repoet med Wishifai-imaget"
  type        = string
  default     = "244530008913.dkr.ecr.eu-west-1.amazonaws.com/wishifai-2"
}

variable "execution_role_arn" {
  description = "Eksisterende task execution role"
  type        = string
  default     = "arn:aws:iam::244530008913:role/ecsTaskExecutionRole"
}

variable "infrastructure_role_arn" {
  description = "Eksisterende infrastructure role for ECS Express"
  type        = string
  default     = "arn:aws:iam::244530008913:role/service-role/ecsInfrastructureRoleForExpressServices"
}

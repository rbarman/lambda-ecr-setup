variable "name" {
    description = "Name of the repos (ECR and Lambda) that we want to create"
    type        = string
    default     = "lambda-workflow-runner"
}
// define variables secret_id , AWS_REGION , SECRET_NAME, ECR_REPO_URI, GIT_REPO

variable "AWS_REGION" {
  type        = string
  description = "The AWS region"
}

variable "ECR_REPO_URI" {
  type        = string
  description = "The URI of the ECR repository"
}
variable "GIT_REPO" {
  type        = string
  description = "The URI of the Git repository"
}

// varaible AWS_ECR_LOGIN

variable "AWS_ECR_LOGIN" {
  type        = string
  description = "The AWS ECR login command"

}


variable "SECRET_NAME" {
  type        = string
  description = "The name of the secret"
  default     = "my-secret"
}


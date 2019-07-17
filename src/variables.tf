variable "estate_name" {
  description = "A name for all of the related stuff in this system."
}

variable "stack_name" {
  description = "A name for this stack."
  default     = "simple-app"
}

variable "environment_name" {
  description = "An identifier to link a collection of stack instances that work together."
}

variable "region" {
  description = "The region into which to deploy the stack."
  default     = "eu-west-2"
}

variable "aws_profile" {
  description = "The profile in ~/.aws/credentials to use."
  default     = "default"
}

variable "assume_role_arn" {
  description = "The IAM role to assume."
  default     = ""
}

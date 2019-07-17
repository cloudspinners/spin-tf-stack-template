provider "aws" {
  version = "~> 2.0"
  region  = var.region
  profile = var.aws_profile

  assume_role {
    role_arn     = var.assume_role_arn
    session_name = "session-${var.environment_name}-${var.aws_profile}"
  }
}


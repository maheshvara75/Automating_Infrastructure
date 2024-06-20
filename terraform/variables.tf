variable "aws_access_key" {
  description = "AWS_ACCESS_KEY"
  default =""
  }
variable "aws_secret_key" {
  description = "AWS_SECRET_KEY"
  default =""
  }
variable "aws_session_token" {
  description = "AWS_ACCESS_TOKEN"
  default=""
  }
variable "key_name" {
  description = "AWS_KEY_NAME"
  default =""
  }
variable "instance_ami" {
  description = "AMI ID for the EC2 instances"
  type        = string
  default     = "ami-04b70fa74e45c3917"
}
variable "instance_type" {
  description = "Instance type for the EC2 instances"
  type        = string
  default     = "t2.micro"
}

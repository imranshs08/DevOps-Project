variable "instance_type" {
  description = "Variable Value for web"
  type = string
  default = "t2.small"
}

variable "bucket_name_prefix" {
  description = "s3 bucket for dev env"
  type = string
  default = "example"
}


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

variable "key_name" {
  description = "key-name for the resource ec2"
  default = "imran-2024.ppk"
}
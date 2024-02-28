variable "allow-ports" {
  default     = [80, 443, 8080]
  description = "allow ports on vpc "
  type        = list(number)
}
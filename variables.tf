variable "aws_region" {
  type    = string
  default = "eu-west-2"
}

variable "authorizer_issuer" {
  type = string
}

variable "authorizer_audience" {
  type = string
}

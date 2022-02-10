terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.48.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.2.0"
    }
  }

  required_version = "~> 1.1.1"
}

provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "lambda_bucket" {
  bucket = "hello-lambda-bucket-cs-mt"

  acl           = "private"
  force_destroy = true
}

data "archive_file" "lambda_hello" {
  type = "zip"

  source_dir  = "${path.module}/hello"
  output_path = "${path.module}/hello.zip"
}

resource "aws_s3_bucket_object" "lambda_hello" {
  bucket = aws_s3_bucket.lambda_bucket.id

  key    = "hello.zip"
  source = data.archive_file.lambda_hello.output_path

  etag = filemd5(data.archive_file.lambda_hello.output_path)
}

module "lambda" {
  source           = "./modules/lambda"
  s3_bucket        = aws_s3_bucket.lambda_bucket.id
  s3_key           = aws_s3_bucket_object.lambda_hello.key
  source_code_hash = data.archive_file.lambda_hello.output_base64sha256
}

module "api_gateway" {
  source            = "./modules/api_gateway"
  integration_uri   = module.lambda.invoke_arn
  function_name     = module.lambda.function_name
  audience          = [var.authorizer_audience]
  authorizer_issuer = var.authorizer_issuer
}

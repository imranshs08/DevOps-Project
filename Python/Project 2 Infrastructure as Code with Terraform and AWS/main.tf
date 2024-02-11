    resource "random_id" "random-value" {
    byte_length = 10
    }


    data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
    owners = ["099720109477"] # Canonical
    }

    resource "aws_instance" "web" {
    ami           = data.aws_ami.ubuntu.id
    instance_type = var.instance_type
    key_name = var.key_name

    tags = {
        Name = "Server-Web"
    }
    }

    # Create S3 bucket
    resource "aws_s3_bucket" "example" {
    bucket  = "imran-${random_id.random-value.hex}"

    tags = {
        Name        = "My bucket"
        Environment = "Dev"
    }
    }

    # Provision RDS database
    resource "aws_db_instance" "example_rds" {
    engine               = "mysql"
    instance_class       = "db.t2.micro"
    allocated_storage    = 20
    storage_type         = "gp2"
    identifier_prefix    = "example-rds"
    username             = "admin"
    password             = "Password123"  # Change to your desired password
    skip_final_snapshot = true
    }



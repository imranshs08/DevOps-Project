resource "aws_instance" "web" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.main-subnet.id
  vpc_security_group_ids = [aws_security_group.sg-web.id]
  tags = {
    Name = "Web-Sever"
  }
  
  provisioner "local-exec" {
    command = "echo Waiting for the Elastic IP to be created ....."
  }
}

resource "null_resource" "delay" {
  triggers = {
    elatic_ip_id = aws_eip.web-eip.id
  }
  provisioner "local-exec" {
    command = "sleep 3"
  }
  depends_on = [ aws_eip.web-eip ]
}


resource "aws_security_group" "sg-web" {
  name   = "im-web"
  vpc_id = aws_vpc.main.id
  depends_on = [ aws_vpc.main ]
  dynamic "ingress" {
    for_each = var.allow-ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  dynamic "egress" {
    for_each = var.allow-ports
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  
  
}

resource "aws_subnet" "main-subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.0/24"
}


resource "aws_eip" "web-eip" {
  instance = aws_instance.web.id
  domain   = "vpc"
}

resource "aws_internet_gateway" "ng-aws" {
  vpc_id = aws_vpc.main.id
  depends_on = [ aws_vpc.main]
}


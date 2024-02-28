data "aws_ami" "ami-ec2" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "architecture"
    values = ["arm64"]
  }
  filter {
    name = "name"
    values = ["al2023-ami-2023*"]
  }
}
resource "aws_instance" "ec2-resource" {
  ami = data.aws_ami.ami-ec2.id
  instance_type = "t2.micro"
  key_name = abs("")
  vpc_security_group_ids = 
  subnet_id = 
  root_block_device {
    volume_size = "30GiB"
    delete_on_termination = false
    tags = {
        Name = "devops-ebs"
    }
  }

}
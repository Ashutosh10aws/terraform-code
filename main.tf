provider "aws"{
  region="eu-west-1"    
}

resource "aws_instance" "web" {
  count                  = 2
  ami                    = "ami-0c9bfc21ac5bf10eb" // Amazon Linux2
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.web.id]
  user_data = templatefile("user_data.sh.tpl", { // Template File
    f_name = "Denis"
    l_name = "Astahov"
    names  = ["John", "Angel", "David", "Victor", "Frank", "Melissa", "Sonya"]
  })

  tags = {
    Name  = "WebServer Built by Terraform 2"
    Owner = "Denis Astahov"
  }
}

resource "aws_security_group" "web" {
  name        = "WebServer-SG-100000000"
  description = "Security Group for my WebServer"

  ingress {
    description = "Allow port HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow port HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow ALL ports"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "WebServer SG by Terraform"
    Owner = "Denis Astahov"
  }
}

resource "aws_eip" "ip2" {}


#-----

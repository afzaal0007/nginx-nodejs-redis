resource "aws_security_group" "jenkins_sg" {
  name        = "${var.jenkins_name}-security-group"
  description = "Allow SSH and HTTP access for Jenkins"
  vpc_id      = var.vpc_id # Uses the VPC ID passed from the root module


  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.jenkins_name}-sg"
  }
}

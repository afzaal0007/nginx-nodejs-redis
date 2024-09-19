resource "aws_instance" "jenkins" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.ssh_key_name
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  # Use the EKS VPC ID
  subnet_id = var.subnet_id
  # Use one of the pub

  iam_instance_profile = aws_iam_instance_profile.jenkins_instance_profile.name

  depends_on = [aws_iam_instance_profile.jenkins_instance_profile,
    aws_eks_cluster.eks
  ]


  user_data = <<-EOF
    #!/bin/bash
    sudo dnf update -y
    sleep 60 # Wait for the system to stabilize and network to initialize
    sudo dnf install java-11-amazon-corretto -y
    sudo curl -fsSL https://pkg.jenkins.io/redhat-stable/jenkins.repo -o /etc/yum.repos.d/jenkins.repo
    sleep 30
 
    sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
  
    sudo dnf clean all

    sudo dnf install jenkins -y --nogpgcheck
    sudo systemctl enable jenkins
    sudo systemctl start jenkins
    sudo dnf install aws-cli -y
    sleep 100
    sudo curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.21.5/2022-10-31/bin/linux/amd64/kubectl
    sleep 100
    sudo chmod +x ./kubectl
    sudo mv ./kubectl /usr/local/bin
    aws eks update-kubeconfig --region ${var.region} --name ${var.cluster_name}
    sleep 100
    sudo dnf update -y
    sudo dnf install git -y
    sudo dnf install nodejs npm -y
    sleep 100
    sudo dnf install docker -y
    sleep 100
sudo systemctl start docker  
sudo systemctl enable docker
sudo usermod -aG docker $USER
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sleep 60
sudo chmod +x /usr/local/bin/docker-compose
sudo mkdir /home/jenkins
sudo chown jenkins:jenkins /home/jenkins
sudo mkdir /home/jenkins/agent
sudo chown -R jenkins:jenkins /home/jenkins/agent



  EOF
  tags = {
    Name = "${var.jenkins_name}-instance"
  }
}

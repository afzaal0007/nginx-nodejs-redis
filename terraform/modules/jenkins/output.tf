output "jenkins_instance_id" {
  description = "The ID of the Jenkins server instance."
  value       = aws_instance.jenkins.id
}

output "jenkins_public_ip" {
  description = "The public IP of the Jenkins server."
  value       = aws_instance.jenkins.public_ip
}

output "jenkins_security_group_id" {
  description = "The security group ID of the Jenkins server."
  value       = aws_security_group.jenkins_sg.id
}

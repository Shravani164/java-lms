#Create ssh key and EC2
provider "aws" {
  alias      = "ec2_provider"
  region     = "ap-south-1"
}
resource "aws_instance" "lms_server" {
  ami           = "ami-0a7cf821b91bcccbc"
  instance_type = "t2.medium"
  subnet_id = "subnet-013a7ffbac2e5c401"
  security_groups = ["sg-08c4cfa203e7f436e"]
  key_name = aws_key_pair.key.id
  tags = {
    Name = "lms-server"
  }
}
resource "aws_key_pair" "key" {
  key_name   = "lms-server"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDIRLz9MLJyZCizG8Lxhjj3iqJdSdu0ucgjpAvikN22783POAcLFbZcJ/yUbrG2ghg6zoIOMGOXL5Tb4w68d6MAYPTSpXThMApGT4J6tXXfW5LQppXnjBA91LkZvCpvzzmFRozonLeShG2fmbUJblkGQePFeNL7lbonVkgZ1n6XLQgM3U4pi2+676gAFdkWu3XIkqm9kmG1ny8WFJ41/dgv9zDzzN0iZM9uKjDqGIJdt6c20ekp7KdCH+OSpqlc62Hk4ANLWwqJ2hfybGku8dJAIm1kvXDAqOehCq/QQRM0I7aeoQHkan5lc+Ld+UB8leZpwrLumXCwDs2vLYyuDjKyOPx2YrRMbyqUqln9JAfmB1S29IcVAd8chfwvmv9RP9XltYhibBqYXYzbxbMSKb1+32DN+3J7gq5fBwTguWk9YqN2Y7VVcMa340oMhSV2SZprmHk/tjMR8RHZCIFwfhFqaA8mSLDsCBENQuwWi4H3t5h4nKzQL2LluMwTzcZn8kc= ADMIN@DESKTOP-U6MT73L"
}

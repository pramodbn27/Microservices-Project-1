### VPC module to create vpc

locals {
  region = var.AWS_REGION
}

data "aws_vpc" "default" {
  default = true
}

# module "key_pair" {
#   source = "terraform-aws-modules/key-pair/aws"

#   key_name           = "user1"
#   create_private_key = true
# }



resource "aws_instance" "master" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.medium"
  associate_public_ip_address = true
  #for_each      = data.aws_subnet_ids.selected.ids
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  # the VPC subnet
  #subnet_id = module.vpc.public_subnets[0]

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id,aws_security_group.Demo-kube-master-sg.id,aws_security_group.Demo-kube-mutual-sg.id]

  # the public SSH key
  #key_name = module.key_pair.key_pair_name
  user_data = local.template_file_int

  tags = {
    Name = "kube-master"
    "kubernetes.io/cluster/kubeadm" = "owned"
    Role = "master"
    type = "terraform"
  }
}

resource "aws_instance" "worker" {
  count         = 1
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"
  #for_each      = data.aws_subnet_ids.selected.ids
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  

  # the VPC subnet
  #subnet_id = module.vpc.public_subnets[0]

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id,aws_security_group.Demo-kube-worker-sg.id,aws_security_group.Demo-kube-mutual-sg.id]

  # the public SSH key
  #key_name = module.key_pair.key_pair_name
  user_data = local.template_file_int

  tags = {
    Name = "kube-worker"
    "kubernetes.io/cluster/kubeadm" = "owned"
    Role = "worker"
    type = "terraform"
    created = "terraform"
  }
}


locals {
   template_file_int  = templatefile("./install_docker_kubectl.tpl", {})
}


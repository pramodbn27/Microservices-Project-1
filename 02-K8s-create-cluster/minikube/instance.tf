resource "aws_instance" "minikube" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.medium"
  #for_each      = data.aws_subnet_ids.selected.ids
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  # the VPC subnet
  subnet_id = tolist(data.aws_subnet_ids.public.ids)[0]

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id,aws_security_group.minikube-worker-sg.id]

  # the public SSH key
  key_name = aws_key_pair.mykeypair.key_name
  user_data = local.template_file_int

  tags = {
    Name = "kube-master"
    "kubernetes.io/cluster/kubeadm" = "owned"
    Role = "master"
    type = "terraform"
  }
}



data "aws_subnet_ids" "private" {
   vpc_id = data.aws_vpc.selected.id

  tags = {
    Name = "Demo-private-1"
  }
}

data "aws_vpc" "selected" {
  tags = {
    Name = "*demo*"
  }
}

data "aws_subnet_ids" "public" {
   vpc_id = data.aws_vpc.selected.id

  tags = {
    Name = "Demo-public-1"
  }
}

locals {
   template_file_int  = templatefile("./install_mini_kube.tpl", {})
}


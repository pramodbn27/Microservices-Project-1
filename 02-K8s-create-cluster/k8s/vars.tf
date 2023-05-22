variable "AWS_REGION" {
  default = "us-east-1"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}

variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-0f387434d1dfc4cc2"
    eu-west-1 = "ami-00622de605b25a7d6"
    ap-south-1 = "ami-0f733fbd96037f20b"
  }
}

variable "subnet" {
  default = "public"
}

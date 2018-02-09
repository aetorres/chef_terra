variable "region" {
    default = "us-west-2"
}

variable "amis" {
    default = {
        us-east-1 = "ami-2452275e"
        us-east-2 = "ami-e97c548c"
        us-west-1 = "ami-ee03078e"
        us-west-2 = "ami-7707a10f"
    }
}

variable "vpc_cidr" {
    default = "10.8.0.0/16"
}

variable "public_subnet_cidr" {
    default = "10.8.0.0/24"
}

variable "instance_type" {
    default = "t2.micro"
}

variable "key_pair" {
    default = "hp-kei-pair"
}

variable "private_key_path" {
    default = "~/.ssh/hp-kei-pair.pem"
}



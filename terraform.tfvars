region = "ap-northeast-1"

common_tags = {
    ManagedBy = "Terraform"
    Team = "Melanated-Cyber-Kings"
    author = "Vany"
  
}

project = "Armageddon"

env = "lab-1a"
############ Network variables

cidr_block = "172.17.0.0/16"

public_subnet_cidr = "172.17.1.0/24"

private_subnet_cidr= "172.17.11.0/24"


################# Security

http_ingress_rule = {
    cidr = "0.0.0.0/0"
    port = 80
    description = "HTTP ingress rule"
}

tcp_ingress_rule = {
    cidr = "172.17.0.0/16"
    port = 3306
    description = "TCP ingress rule"
    
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.11.0"
    }
  }
}

provider "aws" {
  # Configuration options

    resource "aws_security_group" "security-gp" {
        name    = "security-gp-windows"
        Description =   "Development security group for windows servers"
        vpc_id  =   "vpc-0b06f8a3ec918052f"
        ingress{
            cidr_ipv4   = ["172.20.0.0/0"]
            from_port   =   3389
            ip_protocol =   "tcp"
            to_port =   3389
        }

        egress{
            
            from_port   =   0
            ip_protocol =   "-1"
            to_port =   0
            cidr_ipv4   =   ["0.0.0.0/24"]
        }



    }


    resource "aws_iwnstance" "windows_server" {
        name    = "Win-Srv"
        description =   "Servidor credo para desafio 5"
        ami =   "ami-0fc682b2a42e57ca2"
        instance_type   =   "t2.micro"
        vpc_security_group_ids  =   [aws_security_group.security-gp.id]
        key_name    =   "WinSrv-Devops"
        associate_public_ip_address =   true
        subnet_id   =   "private_subnet_1"

        tags    ={
            Name=   "Win-srv"
            Owner   = "matiasolivar@outlook.com"

        }


    }


}
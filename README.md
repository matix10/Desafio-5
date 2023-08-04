1 - Ingresamos en https://registry.terraform.io/, para obtener la configuracion del provider a utilizar. En este caso el de AWS

    terraform {
    required_providers {
        aws = {
        source = "hashicorp/aws"
        version = "5.11.0"
        }
    }
    }

2 - Procedemos con la creacion de nuestro archivo main.tf, el cual tendra el codigo fuente.

3 - El codigo se inicializa con el el codigo del punto 1. Luego procedemos a la creacion de todo lo necesario para crear la instancia de Windows.
    a  -  Mediante los "reources", creamos primero un security group.
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

    b. Como se observa se brinda toda la informacion necesaria para la luego creacion de la instancia solicitada.

    c. Se utiliza resource "aws_instance", para definir la configuracion de la instancia de windows

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

4-  Una vez finalizado el codigo, realizamos un save y procedemos a ejecutar lo siguiente.

    a - Terraform init --> para inicializar e instalar el provider utilizado
    b - Terraform plan --out "name" --> para crear un plan de ejecucion (se verifica la sintaxis tambien).
    c - Terraform apply "plan name" --> ejecutamos el codigo

5- Verificamos que la instancia se haya creado con la configuracion correspondiente.

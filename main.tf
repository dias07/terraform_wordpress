module "vpc" {
  source = "./modules/vpc"
  cidr_block_of_vpc = "10.0.0.0/16"
  
}


module "internet_gateway" {
  source = "./modules/internet_gateway"
  vpc_id =module.vpc.vpc_id
  subnet_id = module.subnets.private_subnet_ids[0]
  eip_id = module.internet_gateway.eip_id
  route_table= module.route_table.public_route_table_id
  subnet_ids = module.subnets.private_subnet_ids
}

module "route_table" {
  source   = "./modules/route_table"
  cidr_block = "0.0.0.0/0"
  vpc_id   = module.vpc.vpc_id
  internet_gateway = module.internet_gateway.internet_gateway
  name_tag = "public_route_table"
  nat_gateway = module.internet_gateway.nat_gateway
  private_name_tag = "private_route_table"
}

module "subnets" {
  source  = "./modules/subnet"
  number = 3
  vpc_id  = module.vpc.vpc_id
  public_route_table_id = module.route_table.public_route_table_id
  private_route_table_id = module.route_table.private_route_table_id
  public_cidr_blocks = ["10.0.10.0/24", "10.0.20.0/24", "10.0.30.0/24"]
  private_cidr_blocks = ["10.0.40.0/24", "10.0.50.0/24", "10.0.60.0/24"]
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"] 
}




    module "security_groups" {
    source = "./modules/security_groups"
    vpc_id = module.vpc.vpc_id
    ingress_rules = [
    {
    from_port   = 22
    to_port     = 22
    protocol  = "tcp"
    description = "Port 22"
    },
    {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    description = "Port 0"
    },
    {
    from_port   = 443
    to_port     = 443
    protocol  = "tcp"
    description = "Port 443"
    },
    {
    from_port   = 80
    to_port     = 80
    protocol  = "tcp"
    description = "Port 80"
    }
    ]
    web_sg_name = "wordpress_sg"

    outside_sg = module.security_groups.web_security_group_id

    ingress_ports = 3306
    rds_sg_name = "rds_sg"
    eigress = ["ingress", "egress"]
    protocol-db = "tcp"
    }


module "ec2_instance" {
  ec2_ami = "ami-0cf10cdf9fcd62d37"
  type_of_instance = "t2.micro"
  source            = "./modules/ec2_instance"
  subnet_id         = module.subnets.public_subnet_ids[0] //0 means subnet-1
  security_group_id = module.security_groups.web_security_group_id
  key_pair = var.key_pair
  key_pair_name     = "ter-key"
  user_data = <<-EOF
  #!/bin/bash
        sudo yum update -y,
        sudo yum install php php-mysqlnd httpd -y,
        wget https://wordpress.org/latest.tar.gz,
        tar -xzf latest.tar.gz,
        sudo cp -r wordpress /var/www/,
        sudo chown -R apache /var/www/,
        sudo chgrp -R apache /var/www/,
        find /var/www -type f -exec sudo chmod 0644 {} \;
        sudo amazon-linux-extras install php8.2
        sudo yum install mariadb,
        sudo amazon-linux-extras enable lamp-mariadb10.2-php7.2=latest,
        sudo yum install mariadb mariadb-server,
        sudo amazon-linux-extras disable lamp-mariadb10.2-php7.2=latest,
        sudo usermod -a -G apache ec2-user
        sudo systemctl enable httpd,
        sudo systemctl status httpd,
        sudo systemctl start httpd,
        sudo systemctl reboot httpd,
        sudo systemctl enable mariadb,
        sudo systemctl status mariadb,
        sudo systemctl start mariadb
        

EOF
}


module "rds_instance" {
  source                  = "./modules/rds_instance"
  name-db_subnet_group = "db-subnet-group"
  private_subnet_ids      = module.subnets.private_subnet_ids
  security_group_id       = module.security_groups.rds_security_group_id
  engine               = "mysql"
  allocated_storage    =  20
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  username             = var.username
  password             = var.password
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}




resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
  
}

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.0.0/17"
    map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id
    
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
  
}

resource "aws_route_table_association" "a" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.public.id
  
}

resource "aws_security_group" "sg" {
    vpc_id = aws_vpc.main.id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 3000
        to_port = 3000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]

    }
}
resource "aws_instance" "jenkins" {
    ami = "ami-05cf1e9f73fbad2e2"
    instance_type = var.jenkins_instance_type
    subnet_id = aws_subnet.public.id
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.sg.id]
    tags = {
        Name ="jenkins-server"
    }
  
}

resource "aws_instance" "app" {
    ami = "ami-05cf1e9f73fbad2e2"
    instance_type = var.app_instance_type
    subnet_id = aws_subnet.public.id
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.sg.id]
    tags = {
      Name = "app-server"
    }
}

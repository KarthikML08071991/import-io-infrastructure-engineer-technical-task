provider "aws" {
    region = "ap-south-1"  
}

resource "aws_instance" "ec2_io" {
    ami = "ami-0851b76e8b1bce90b"
    instance_type = "t2.micro"
    tags = {
        Name: "import_io1"
    }
}

resource "aws_eip" "ec2_io_public_ip" {
    instance = aws_instance.ec2_io.id
    public_ip = "107.22.40.20"

}

resource "aws_security_group" "name" {
  name = "EC2_Seurity_group"
  description = "SG for conneting to RDS through port 3306"

  ingress{
      from_port = 3306
      to_port = aws_instance.ec2_io
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port = 0
      to_port = 65535
      protocol = "tcp"
      cidr_blocks = "0.0.0.0/0"
  }

  tags = {
      Name: "RDS Security Port"
  }
}

resource "aws_db_instance" "import_rds" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "mydb"
  username             = "root"
  password             = "admin123"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}

resource "aws_eip" "rds_public_ip" {
  instance = aws_db_instance.import_rds
  public_ip = "18.215.226.36"
}
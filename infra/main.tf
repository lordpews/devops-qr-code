resource "aws_vpc" "eks_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "eks_vpc"
  }
}

resource "aws_internet_gateway" "eks_igw" {
  vpc_id = aws_vpc.eks_vpc.id
  tags = {
    Name = "eks_igw"
  }
}


resource "aws_subnet" "eks_subnet_1" {
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-south-2a"
  map_public_ip_on_launch = true
}
resource "aws_subnet" "eks_subnet_2" {
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-south-2b"
  map_public_ip_on_launch = true
}
resource "aws_subnet" "eks_subnet_3" {
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-south-2c"
  map_public_ip_on_launch = true
}

resource "aws_route_table" "eks_vpc_route_table" {
  vpc_id = aws_vpc.eks_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks_igw.id
  }

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }
}

resource "aws_route_table_association" "subnet_1_attach" {
  subnet_id      = aws_subnet.eks_subnet_1.id
  route_table_id = aws_route_table.eks_vpc_route_table.id
}
resource "aws_route_table_association" "subnet_2_attach" {
  subnet_id      = aws_subnet.eks_subnet_2.id
  route_table_id = aws_route_table.eks_vpc_route_table.id
}
resource "aws_route_table_association" "asubnet_3_attach" {
  subnet_id      = aws_subnet.eks_subnet_3.id
  route_table_id = aws_route_table.eks_vpc_route_table.id
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "project-cluster"
  cluster_version = "1.31"

  cluster_endpoint_public_access = true

  enable_cluster_creator_admin_permissions = true

  vpc_id                   = aws_vpc.eks_vpc.id
  subnet_ids               = [aws_subnet.eks_subnet_1.id, aws_subnet.eks_subnet_2.id, aws_subnet.eks_subnet_3.id]
  control_plane_subnet_ids = [aws_subnet.eks_subnet_1.id, aws_subnet.eks_subnet_2.id, aws_subnet.eks_subnet_3.id]

  eks_managed_node_groups = {
    project_node_group = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      instance_types = ["t3.medium"]

      min_size     = 1
      max_size     = 1
      desired_size = 1
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
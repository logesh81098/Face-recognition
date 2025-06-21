output "vpc-id" {
  value = aws_vpc.Face-Recognition-vpc.id
}

output "subnet-1" {
  value = aws_subnet.public-subnet-1.id
}

output "subnet-2" {
  value = aws_subnet.public-subnet-2.id
}
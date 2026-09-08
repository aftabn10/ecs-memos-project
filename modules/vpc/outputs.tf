output "vpc_id" {
  value = aws_vpc.vpc_memos.id
}

output "public_subnet_ids" {
  value = [
    for key, subnet in aws_subnet.public_subnet : subnet.id
  ]
}

output "private_subnet_ids" {
  value = [
    for key, subnet in aws_subnet.private_subnet : subnet.id
  ]
}

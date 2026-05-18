output "vpc_id" {
    value = aws_vpc.vpc_memos.id
}

output "public_subnet_ids" {
  value = [
    aws_subnet.public_subnet_memos_a.id,
    aws_subnet.public_subnet_memos_b.id
  ]
}

output "private_subnet_ids" {
  value = [aws_subnet.private_subnet_memos.id]
}

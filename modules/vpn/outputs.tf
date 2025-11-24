output "customer_gateway_id" {
  value = aws_customer_gateway.cg.id
}

output "vpn_gateway_id" {
  value = aws_vpn_gateway.vgw.id
}

output "vpn_connection_id" {
  value = aws_vpn_connection.connection.id
}
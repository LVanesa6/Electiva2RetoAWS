# Customer Gateway - aws a az
resource "aws_customer_gateway" "cg" {
  bgp_asn    = 65010
  ip_address = var.azure_vpn_public_ip
  type       = "ipsec.1"

  tags = merge(var.tags, {
    Name = "azure-customer-gateway"
  })
}

# VPN Gateway
resource "aws_vpn_gateway" "vgw" {
  vpc_id = var.vpc_id

  tags = merge(var.tags, {
    Name = "aws-vpn-gateway"
  })
}

# VPN Connection
resource "aws_vpn_connection" "connection" {
  vpn_gateway_id      = aws_vpn_gateway.vgw.id
  customer_gateway_id = aws_customer_gateway.cg.id
  type                = "ipsec.1"

  static_routes_only = true

  tunnel1_preshared_key = var.shared_key
  tunnel2_preshared_key = var.shared_key

  # CIDRs para cada túnel, deben ser /30 y parte del rango 169.254.0.0/16
  tunnel1_inside_cidr = "169.254.10.0/30"
  tunnel2_inside_cidr = "169.254.11.0/30"

  tags = merge(var.tags, {
    Name = "aws-azure-s2s"
  })
}


# Ruta estática en la conexión: hacia la VNet de Azure (no hacia tu VPC)
resource "aws_vpn_connection_route" "route_to_azure" {
  vpn_connection_id      = aws_vpn_connection.connection.id
  destination_cidr_block = var.azure_vnet_cidr
}


# Ruta en el route table de la VPC
data "aws_route_tables" "vpc_rts" {
  vpc_id = var.vpc_id
}

resource "aws_route" "vpc_to_azure" {
  for_each = toset(var.route_table_ids)

  route_table_id         = element(data.aws_route_tables.vpc_rts.ids, count.index)
  destination_cidr_block = var.azure_vnet_cidr
  gateway_id             = aws_vpn_gateway.vgw.id
}
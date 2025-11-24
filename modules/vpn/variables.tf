variable "vpc_id" {
  description = "ID de la VPC donde se atachará el VPN Gateway"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR interno de la VPC que será accesible desde Azure"
  type        = string
}

variable "azure_vpn_public_ip" {
  description = "IP pública del Azure Virtual Network Gateway"
  type        = string
}

variable "shared_key" {
  description = "Shared secret usada para la VPN en ambos lados"
  type        = string
}

variable "tags" {
  description = "Tags para los recursos de AWS"
  type        = map(string)
  default     = {}
}

variable "azure_vnet_cidr" {
  description = "CIDR de la VNet de Azure"
  type        = string
}

variable "route_table_ids" {
  type = list(string)
}
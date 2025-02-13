variable "location" {
  type        = string
  description = "The Azure location where the resources will be deployed."
  nullable    = false
}

variable "name" {
  type        = string
  description = "The name of the Key Vault."
}

variable "resource_group_name" {
  type        = string
  description = "The resource group where the resources will be deployed."
}

variable "tenant_id" {
  type        = string
  description = "The Azure tenant ID used for authenticating requests to Key Vault. You can use the `azurerm_client_config` data source to retrieve it."
}

variable "sku_name" {
  type        = string
  default     = "premium"
  description = "The SKU name of the Key Vault. Default is `premium`. Possible values are `standard` and `premium`."
}

variable "tags" {
  default     = {}
  description = "Common tags"
}

variable "network_acls_bypass" {
  description = "(Required) Specifies which traffic can bypass the network rules. Possible values are AzureServices and None."
  default     = "AzureServices"
}

variable "network_acls_default_action" {
  description = "(Required) The Default Action to use when no rules match from ip_rules / virtual_network_subnet_ids. Possible values are Allow and Deny."
}

variable "network_acls_ips_rules" {
  description = "(Optional) One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault."
  default     = null
}

variable "role_assignment" {
  description = <<EOT
    azure_group_reader = {
      principal_id: "(Required) The ID of the Principal (User, Group or Service Principal) to assign the Role Definition to. Changing this forces a new resource to be created."
      role_definition_name: "(Optional) The name of a built-in Role. Changing this forces a new resource to be created. Conflicts with role_definition_id."
    }
  EOT
}

variable "subnet_id" {
  description = "The subnet to be joined."
}

variable "enable_private_endpoint" {
  description = "Join the Azure resource to a VNet."
}
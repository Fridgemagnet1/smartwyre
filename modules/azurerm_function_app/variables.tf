variable "resource_group" {
  description = "The resource group for the environment containing app service plan, function app, service bus"
}

variable "tags" {
  default     = {}
  description = "Common tags"
}

variable "app_config_uri" {
  type = string
}

variable "app_config_id" {
  type = string
}

variable "functions" {
  description = "List of functions to be created"
}

variable "ap_sku_name" {
  type        = string
  default     = "Y1"
  description = "The sku of the App Service Plan. Possible values are: Premium = P1v2, P2v2, P3v2, Dynamic = Y1"
}

variable "diagnostic_settings_enabled" {
  type        = bool
  default     = true
  description = "[Optional] Whether to enable diagnostic settings for the functions and their storage accounts."
}

variable tenant_id {
  type = string
}

variable key_vault_id {
  type = string
}

##############################
##General Variables##

variable "location" {
  type        = string
  description = "Azure region where the resource should be deployed."
  nullable    = false
}

variable "name" {
  type        = string
  description = "The name which should be used for the Function App."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group where the App Service will be deployed."
}

variable "service_plan_resource_id" {
  type        = string
  description = "The resource ID of the App Service Plan to deploy the App Service in in."
}

variable "storage_account_name" {
  type        = string
  default     = null
  description = "The name of the Storage Account to deploy the Function App in."
}

variable "storage_account_access_key" {
  type        = string
  default     = null
  description = "The access key of the Storage Account to deploy the Function App in. Conflicts with `storage_uses_managed_identity`."
  sensitive   = true
}

variable "storage_uses_managed_identity" {
  type        = bool
  default     = false
  description = "Should the Storage Account use a Managed Identity? Conflicts with `storage_account_access_key`."
}

variable "https_only" {
  type        = bool
  default     = false
  description = "Should the Function App only be accessible over HTTPS?"
}

variable "client_certificate_mode" {
  type        = string
  default     = "Required"
  description = "The client certificate mode for the Function App."
}

variable "functions_extension_version" {
  type        = string
  default     = "~4"
  description = "The version of the Azure Functions runtime to use. Defaults to `~4`."
}

variable "app_settings" {
  type = map(string)
  default = {}
  description = "A map of key-value pairs for [App Settings](https://docs.microsoft.com/en-us/azure/azure-functions/functions-app-settings) and custom values to assign to the Function App. "
}
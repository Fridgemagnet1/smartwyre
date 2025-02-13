variable "function_app_names" {
  type = list(string)
  default = [
    "pricing",
    "products",
    "rebates"
  ]
}

variable "tenant_id" {
  description = "The tenant id of where the resources will be deployed"
}

variable "subscription_id" {
  description = "The subscription id of where the resources will be deployed"
}

variable "authorized_ips" {
  description = "Allowed IPs for kv access"
}
variable "grafana_url" {
  type = string
  description = "Where is your Grafana ? Should look like https://mystack.grafana.net/ in Grafana Cloud (or other domains if OSS or Enterprise)"
}

variable "my_token" {
  type = string
  description = "Your API token to manage this Grafana"
  sensitive = true
}

variable "my_email" {
  type = string
  description = "Your email address to receive alerts"
  default = "my-email@company.com"
}
terraform {
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = "2.6.1"
    }
  }
}

variable "grafana_url" {
  type = string
  description = "Where is your Grafana ? Should look like https://mystack.grafana.net/ in Grafana Cloud (or other domains if OSS or Enterprise)"
}

variable "my_token" {
  type = string
  description = "Your API token to manage this Grafana"
  sensitive = true
}

# Set informations about where is your Grafana
provider "grafana" {
    url = var.grafana_url
    auth = var.my_token
}


# My resources to deploy 
resource "grafana_data_source" "my_datasource" {
  name = "My Terraform Datasource"
  type = "grafana-testdata-datasource"
}

resource "grafana_folder" "my_folder" {
  title = "My Terraform folder"
}

resource "grafana_dashboard" "my_dashboard" {
  folder = grafana_folder.my_folder.id # Reuse the folder we created. We call its ID
  config_json = templatefile("${path.module}/my-dashboard.tftpl", { mydatasource-uid = grafana_data_source.my_datasource.uid }) # Use a provided JSON file and update the variable using my datasource. I created this dashboard visually in Grafana, then I replaced the datasource's UID by a variable placeholder.
}
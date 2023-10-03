resource "shoreline_notebook" "apache_http_server_modsecurity_alerts_incident" {
  name       = "apache_http_server_modsecurity_alerts_incident"
  data       = file("${path.module}/data/apache_http_server_modsecurity_alerts_incident.json")
  depends_on = [shoreline_action.invoke_apache_upgrade]
}

resource "shoreline_file" "apache_upgrade" {
  name             = "apache_upgrade"
  input_file       = "${path.module}/data/apache_upgrade.sh"
  md5              = filemd5("${path.module}/data/apache_upgrade.sh")
  description      = "Ensure that the Apache HTTP Server and ModSecurity are up-to-date with the latest patches and versions to address any known vulnerabilities."
  destination_path = "/agent/scripts/apache_upgrade.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_apache_upgrade" {
  name        = "invoke_apache_upgrade"
  description = "Ensure that the Apache HTTP Server and ModSecurity are up-to-date with the latest patches and versions to address any known vulnerabilities."
  command     = "`chmod +x /agent/scripts/apache_upgrade.sh && /agent/scripts/apache_upgrade.sh`"
  params      = ["APACHE_PACKAGE_NAME","MODSECURITY_PACKAGE_NAME"]
  file_deps   = ["apache_upgrade"]
  enabled     = true
  depends_on  = [shoreline_file.apache_upgrade]
}


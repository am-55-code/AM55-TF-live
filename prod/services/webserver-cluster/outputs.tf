output "webserver_address" {
  value = module.webserver-vmss.webserver_address
  description = "The IP address for the Load Balancer"    
  }
# output "external_ip_address_app" {
#   value = yandex_compute_instance.app.network_interface.0.nat_ip_address
# }

output "external_ip_address_app" {
  value = [
    for instance in yandex_compute_instance.app :
    instance.network_interface.0.nat_ip_address
  ]
}

output "external_ip_address_load_balancer" {
  value = [
    for item in yandex_lb_network_load_balancer.reddit-lb.listener.*.external_address_spec:
    item
  ]
}

variable public_key_path {
  description = "Path to the public key for user ubuntu used for ssh access"
}
variable public_key_appuser_path {
  description = "Path to the public key for user appuser used for ssh access"
}
variable private_key_path {
  description = "Path to the private key used for ssh access"
}
variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}
variable subnet_id {
  description = "Subnet for modules"
}
variable db_internal_ip {
  description = "Databes IP address"
}

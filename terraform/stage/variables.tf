variable cloud_id {
  description = "Cloud"
}
variable folder_id {
  description = "Folder"
}
variable zone {
  description = "Zone"
  default     = "ru-central1-a"
}
variable reddit_app_zone {
  description = "Zone for Reddit application instance"
  default     = "ru-central1-a"
}
variable reddit_app_instance_count {
  description = "Count of instance for running reddit application"
  default     = "1"
}
variable public_key_path {
  description = "Path to the public key for user ubuntu used for ssh access"
}
variable public_key_appuser_path {
  description = "Path to the public key for user appuser used for ssh access"
}
variable image_id {
  description = "Disk image"
}
variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}
variable db_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-db-base"
}
variable subnet_id {
  description = "Subnet"
}
variable service_account_key_file {
  description = "key .json"
}
variable private_key_path {
  description = "Path to the private key used for ssh access"
}

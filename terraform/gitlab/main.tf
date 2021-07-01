provider "yandex" {
  version                  = "0.35"
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

data "yandex_compute_image" "ubuntu-image" {
  family = "ubuntu-1804-lts"
}

data "yandex_vpc_network" "default" {
  name = "default"
}

data "yandex_vpc_subnet" "default_central1_a" {
  name = "default-ru-central1-a"
}

resource "yandex_compute_instance" "gitlab_srv" {
  count = var.instance_count
  name  = "gitlab-srv-${count.index + 1}"
  labels = {
    tags = "gitlab-srv"
  }

  resources {
    cores         = 2
    core_fraction = 5
    memory        = 4
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-image.image_id
      size     = 50
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id = data.yandex_vpc_subnet.default_central1_a.subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

}

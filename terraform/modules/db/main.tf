resource "yandex_compute_instance" "db" {
  name = "reddit-db"
  labels = {
    tags = "reddit-db"
  }

  resources {
    cores         = 2
    core_fraction = 5
    memory        = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.db_disk_image
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta.yml")}"
    # ssh-keys = "ubuntu:${file(var.public_key_path)}"
    # ssh-keys = "appuser:${file(var.public_key_appuser_path)}"
  }

  # connection {
  #   type = "ssh"
  #   host        = self.network_interface.0.nat_ip_address
  #   user        = "ubuntu"
  #   agent       = false
  #   private_key = file(var.private_key_path)
  # }

  # provisioner "remote-exec" {
  #   inline = [
  #     "sudo sed -i -e 's/127.0.0.1/127.0.0.1,${yandex_compute_instance.db.network_interface.0.ip_address}/g' /etc/mongod.conf",
  #     "sudo systemctl restart mongod",
  #   ]
  # }
}


resource "yandex_vpc_network" "course_network" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "course_subnet" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.course_network.id
  v4_cidr_blocks = var.default_cidr
}

resource "yandex_compute_instance" "workspace" {
  name               = "workspace"
  platform_id        = "standard-v1"
  service_account_id = yandex_iam_service_account.yc_toolbox.id
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.toolbox.id
      size     = var.vm_base.disk_size
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.course_subnet.id
    nat       = true
  }
  resources {
    cores         = var.vm_base.cores
    memory        = var.vm_base.memory
    core_fraction = var.vm_base.core_fraction
  }
  allow_stopping_for_update = true
  metadata                  = local.ssh_keys_and_serial_port
}

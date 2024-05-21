data "yandex_compute_image" "toolbox" {
  family = var.vm_base.image_family
}

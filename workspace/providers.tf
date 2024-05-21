terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }

  required_version = ">=0.13"
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}

resource "yandex_iam_service_account" "yc_toolbox" {
  name        = "yc-toolbox"
  description = "Account for yandex course devsecops"
  folder_id   = var.folder_id
}

resource "yandex_resourcemanager_folder_iam_member" "yc_toolbox-iam" {
  folder_id = var.folder_id
  role      = "admin"
  member    = "serviceAccount:${yandex_iam_service_account.yc_toolbox.id}"
}

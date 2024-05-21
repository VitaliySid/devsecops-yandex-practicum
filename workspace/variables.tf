
variable "token" {
  type = string
}

variable "cloud_id" {
  type = string
}

variable "folder_id" {
  type = string
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "kubernetes"
  description = "VPC network&subnet name"
}

variable "vm_base" {
  type = map(any)
  default = {
    cores         = 2,
    memory        = 2,
    core_fraction = 20,
    image_family  = "toolbox"
    disk_size     = 30
  }
}

variable "token" {
  type = string
}

variable "cloud_id" {
  type = string
}

variable "folder_id" {
  type = string
} 

variable "vm_base" {
  type = map(any)
  default = {
    cores         = 4,
    memory        = 8,
    core_fraction = 20,
    image_family  = "toolbox"
    disk_size     = 64
  }
}
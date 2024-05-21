output "workspace_ip" {
  value = "${yandex_compute_instance.workspace.name} - ${yandex_compute_instance.workspace.network_interface.0.ip_address}(${yandex_compute_instance.workspace.network_interface.0.nat_ip_address})"
}

output "service_account" {
  value = "service_account_id = ${yandex_iam_service_account.yc_toolbox.id}"
}

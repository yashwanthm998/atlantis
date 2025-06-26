resource "google_service_account" "service_account" {
  account_id = var.sa.account_id
  display_name = var.sa.display_name
}

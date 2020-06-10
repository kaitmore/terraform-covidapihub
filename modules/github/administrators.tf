resource "github_membership" "administrator" {

  for_each = var.administrators

  role     = "admin"
  username = each.value
}

resource "github_membership" "member" {

  for_each = var.members

  role     = "member"
  username = each.value

}

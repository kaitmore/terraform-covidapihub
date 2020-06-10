resource "github_membership" "member" {

  for_each = var.members

  role     = "member"
  username = each.value

}

resource "github_repository_collaborator" "kaitmore" {
  for_each   = var.repositories
  repository = each.value
  username   = "kaitmore"
  permission = "maintain"
}

resource "github_repository_collaborator" "chrisbsmith" {
  for_each   = var.repositories
  repository = each.value
  username   = "chrisbsmith"
  permission = "maintain"
}

resource "github_repository_collaborator" "hiromis" {
  for_each   = var.repositories
  repository = each.value
  username   = "hiromis"
  permission = "maintain"
}

resource "github_repository_collaborator" "dontlaugh" {
  for_each   = var.repositories
  repository = each.value
  username   = "dontlaugh"
  permission = "maintain"
}

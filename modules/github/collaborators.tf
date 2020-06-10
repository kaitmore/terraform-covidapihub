
resource "github_repository_collaborator" "terraform-covidapihub_collaborator" {
  for_each = var.collaborator

  username   = each.value
  repository = "terraform-covidapihub"
  permission = "maintain"
}

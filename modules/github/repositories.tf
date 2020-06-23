resource "github_repository" "repository" {

  for_each = var.repositories

  name               = each.value
  description        = ""
  archived           = false
  homepage_url       = ""
  private            = false
  has_issues         = true
  allow_merge_commit = false
  allow_squash_merge = true
  allow_rebase_merge = false
  has_downloads      = false
  has_projects       = false
  has_wiki           = false
  topics             = []
  auto_init          = false
}

resource "github_branch_protection" "master" {

  for_each = var.repositories

  repository     = each.value
  branch         = "master"
  enforce_admins = false

  required_pull_request_reviews {
    dismiss_stale_reviews           = false
    require_code_owner_reviews      = false
    required_approving_review_count = 1
  }
}

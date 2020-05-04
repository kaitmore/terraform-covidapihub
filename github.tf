module "github" {
  source = "./modules/github"

  members = [
    "chrisbsmith",
    "kaitmore",
  ]

  repositories = [
    "datasource-inshift",
  ]
}

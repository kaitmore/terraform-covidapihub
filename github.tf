module "github" {
  source = "./modules/github"

  members = [
    "chrisbsmith",
    "kaitmore",
  ]

  collaborators = [
    "chrisbsmith",
    "kaitmore",
    "hiromis",
    "dontlaugh"
  ]

  repositories = [
    "datasource-inshift",
    "terraform-covidapihub",
  ]
}

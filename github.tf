module "github" {
  source = "./modules/github"

  administrators = [
    "chrisbsmith",
    "kaitmore",
    "dontlaugh",
    "hiromis",
  ]

  members = [
  ]

  repositories = [
    "datasource-inshift",
    "terraform-covidapihub",
  ]
}

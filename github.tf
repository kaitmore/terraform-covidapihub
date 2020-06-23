module "github" {
  source = "./modules/github"

  administrators = [
    "chrisbsmith",
    "kaitmore",
    "dontlaugh",
  ]

  members = [
    "dontlaugh",
    "hiromis",
  ]

  repositories = [
    "datasource-inshift",
    "terraform-covidapihub",
  ]
}

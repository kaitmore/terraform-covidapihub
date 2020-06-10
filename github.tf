module "github" {
  source = "./modules/github"

  administrators = [
    "chrisbsmith",
    "kaitmore",
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

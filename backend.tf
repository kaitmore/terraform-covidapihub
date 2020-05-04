terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "covidapihub"

    workspaces {
      name = "terraform-covidapihub"
    }
  }
}

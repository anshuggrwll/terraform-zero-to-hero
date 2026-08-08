provider "aws" {
  region = "us-east-1"
}

provider "vault" {
  address = "http://13.220.186.230:8200"
  token   = ""
  skip_child_token = true
}

data "vault_kv_secret_v2" "example" {
  mount = "secret"
  name  = "secret"
}

resource "aws_instance" "my_instance" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"

  tags = {
    Name = "test"
    Secret = data.vault_kv_secret_v2.example.data["test-secret"]
  }
}

provider "aws" {
  alias  = "south"
  region = "ap-south-1"
}

 resource "aws_instance" "demo-server" {
  ami           = "ami-013e83f579886baeb"
  instance_type = "t2.micro"
  key_name     = "dpp-keypair"
 }
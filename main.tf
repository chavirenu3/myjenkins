provider "aws" {
  region = "ap-south-1"  # Specify your region
}

resource "aws_instance" "example" {
  ami           = "ami-05c179eced2eb9b5b"  # Example AMI ID, change it based on your region
  instance_type = "t2.micro"
  key_name      = "mynewsshkey"  # Replace with your SSH key

  tags = {
    Name = "TerraformEC2"
  }
}

output "instance_public_ip" {
  value = aws_instance.example.public_ip
}


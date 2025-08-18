# backend.tf

resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = "mi-bucket-de-estado-terraform-devops" # ¡IMPORTANTE! El nombre debe ser único globalmente

  tags = {
    Name = "Terraform State Bucket"
  }
}
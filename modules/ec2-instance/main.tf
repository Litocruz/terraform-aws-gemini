#resource "aws_key_pair" "mi_llave_ec2" {
#  key_name   = var.public_key_name
#  public_key = file("~/.ssh/id_ed25519.pub")
#}

data "aws_ssm_parameter" "password" {
  name = "/mi-proyecto/password"
}

resource "aws_instance" "devops_instance" {
  # El AMI ID es el ID de la imagen de la máquina virtual.
  # Para LocalStack, este valor puede ser cualquier cosa que siga el formato.
  ami = "ami-0de716d6197524dd9"

  # El tipo de instancia, por ejemplo, "t2.micro" que es elegible para la capa gratuita.
  instance_type = "t2.micro"

  #key_name = aws_key_pair.mi_llave_ec2.key_name

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = templatefile("${path.module}/userdata.sh", {
    password = data.aws_ssm_parameter.password.value
  })

  tags = {
    Name = "instancia-con-servidor-web"
  }
}
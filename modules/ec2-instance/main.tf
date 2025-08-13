#resource "aws_key_pair" "mi_llave_ec2" {
#  key_name   = var.public_key_name
#  public_key = file("~/.ssh/id_ed25519.pub")
#}

resource "aws_instance" "devops_instance" {
  # El AMI ID es el ID de la imagen de la máquina virtual.
  # Para LocalStack, este valor puede ser cualquier cosa que siga el formato.
  ami = "ami-0c55b159cb61040f7"

  # El tipo de instancia, por ejemplo, "t2.micro" que es elegible para la capa gratuita.
  instance_type = "t2.micro"

  #key_name = aws_key_pair.mi_llave_ec2.key_name

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = file("${path.module}/userdata.sh")

  tags = {
    Name = "instancia-con-servidor-web"
  }
}

# modules/ec2-instance/main.tf

resource "aws_instance" "devops_instance" {
  ami           = "ami-0c55b159cb61040f7"
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = file("${path.module}/userdata.sh")

  tags = {
    Name = "instancia-con-servidor-web"
  }
}
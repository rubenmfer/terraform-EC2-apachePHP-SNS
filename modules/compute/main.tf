provider "aws" {
  region = "us-east-1"  
}

resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
 
  tags = {
    Name = "WebServer"
  }
 
  # Define el Security Group para permitir tráfico HTTP y SSH
  vpc_security_group_ids = [aws_security_group.web_sg.id]
 
  provisioner "file" {
    source      = "./modules/compute/userdata/${var.script}"
    destination = "/tmp/${var.script}"
  }
  
  provisioner "file" {
    source      = "./modules/compute/userdata/index.html"
    destination = "/tmp/index.html"
  }
  
  provisioner "file" {
    source      = "./modules/compute/userdata/submit.php"
    destination = "/tmp/submit.php"
  }
  
 
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/${var.script}",
      "sudo /tmp/${var.script}",
      "sudo mv /tmp/index.html /var/www/html/",
      "sudo mv /tmp/submit.php /var/www/html/",
      "sudo sed -i 's/arn:aws:sns:us-east-1:XXXXXXX:test/${var.sns_topic_arn}/g' /var/www/html/submit.php",
      "sudo sed -i '/AddEncoding x-gzip .gz .tgz/a AddType application/x-httpd-php .php' /etc/httpd/conf/httpd.conf",
      "sudo systemctl restart httpd"
    ]
  }
 
  connection {
    type        = "ssh"
    user        = var.ssh_user
    private_key = file("./modules/compute/userdata/${var.ssh_fname}")  # Ruta a tu clave privada
    host        = self.public_ip
  }
}


resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Allow HTTP and SSH traffic"
 
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

/*
data "aws_iam_role" "LabRole" {
  name = "LabRole"
}

resource "aws_iam_policy_attachment" "sns_policy" {
  name       = "sns-policy"
  roles      = [data.aws_iam_role.LabRole.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonSNSFullAccess"
}
*/
provider "aws" {
  region = var.region
}

resource "aws_instance" "myfirstinstance" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  associate_public_ip_address = true

  tags = {
    Name = "terraform-provisioner-demo"
  }

  # -----------------------------
  # 1️⃣ REMOTE-EXEC (INLINE)
  # Install nginx
  # -----------------------------
  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install -y nginx"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("nidhi-outlook.pem")
      host        = self.public_ip
      timeout     = "5m"
    }
  }

  # -----------------------------
  # 2️⃣ FILE provisioner
  # -----------------------------
  provisioner "file" {
    source      = "index.html"
    destination = "/tmp/index.html"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("nidhi-outlook.pem")
      host        = self.public_ip
      timeout     = "5m"
    }
  }

  # -----------------------------
  # 3️⃣ REMOTE-EXEC (SCRIPT)
  # -----------------------------
  provisioner "remote-exec" {
    script = "install-nginx.sh"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("nidhi-outlook.pem")
      host        = self.public_ip
      timeout     = "5m"
    }
  }

  # -----------------------------
  # 4️⃣ REMOTE-EXEC (SCRIPTS)
  # -----------------------------
  provisioner "remote-exec" {
    scripts = [
      "update.sh",
      "start-nginx.sh"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("nidhi-outlook.pem")
      host        = self.public_ip
      timeout     = "5m"
    }
  }

  # -----------------------------
  # 5️⃣ FINAL CONFIG
  # -----------------------------
  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/index.html /var/www/html/index.html",
      "sudo systemctl enable nginx",
      "sudo systemctl restart nginx"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("nidhi-outlook.pem")
      host        = self.public_ip
      timeout     = "5m"
    }
  }

  # -----------------------------
  # 6️⃣ LOCAL-EXEC
  # -----------------------------
  provisioner "local-exec" {
    command = "echo EC2 created with IP ${self.public_ip} >> ec2_ips.txt"
  }
}

resource "aws_instance" "cd-server" {
  count = 1
  ami = "ami-0211a02d5229d4956"
  instance_type = "t2.micro"
  key_name = "${var.aws_key_pair}"
  security_groups = [
    "${aws_security_group.cd_instance_security_group.name}"]
  tags = {
    Name = "CD Server Instance TIMESTAMP"
  }
}
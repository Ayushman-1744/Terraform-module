variable "username" {
  description = "Enter username"
  type = string
  #default = "ec2-ebs"
}
variable "size" {
  description = "Enter value for size of EBS"
  type = number
  #default = 10
}
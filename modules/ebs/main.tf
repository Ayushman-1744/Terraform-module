resource "aws_iam_user" "username" {
    count = 5
    name = "cloud-institute-user-${count.index + 1}"
    tags = {
        Name = "${var.username}-${count.index + 1}"
    }
}


#resource "aws_iam_user" "cloud-forset-user" {
 #   for_each = toset(["sam", "pam", "kim", "tom"])
  #  name = "cloud-institute-user-${each.value}"
   # tags = {
    #    Name = "cloud-user-${each.value}"
    #}
#}
  
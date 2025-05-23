resource "aws_iam_user" "my_user" {
  name = "${var.username}"
}
resource "aws_iam_user_policy_attachment" "attach_policy" {
  user       = aws_iam_user.my_user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_group" "my_group" {
  name = "${var.group_name}"
}

resource "aws_iam_user_group_membership" "example_membership" {
  user = aws_iam_user.my_user.name

  groups = [
    aws_iam_group.my_group.name
  ]
}
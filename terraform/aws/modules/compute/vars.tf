variable "vpc_id" {}
variable "sn_vpc_pub1a" {}
variable "sn_vpc_pub1b" {}
variable "ec2_ami" {
type    = string
   default = "ami-02e136e904f3da870"
   validation {
       condition = (
           length(var.ec2_ami) > 4 &&
           substr(var.ec2_ami, 0, 4) == "ami-"
       )
       error_message = "O valor deve iniciar com \"ami-\"."
   }
}
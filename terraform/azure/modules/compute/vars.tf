variable "rgname" {}
variable "rglocation" {}
variable "vnet" {}
variable "snvnetpub1a" {}
variable "snvnetpub1b" {}
variable "vm_size" {
type    = string
   default = "Standard_B2s"
   validation {
       condition = (
           length(var.ec2_ami) > 4 &&
           substr(var.ec2_ami, 0, 4) == "Standard_"
       )
       error_message = "O valor deve iniciar com \"Standard_\"."
   }
}
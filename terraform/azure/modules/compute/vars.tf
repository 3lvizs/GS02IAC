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
           length(var.vm_size) > 4 &&
           substr(var.vm_size, 0, 4) == "Standard_"
       )
       error_message = "O valor deve iniciar com \"Standard_\"."
   }
}
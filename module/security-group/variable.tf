variable "vpc-id" {
  default = {}
}

variable "HTTPS-Port" {
  default = "443"
}

variable "SSH-Port" {
  default = "22"
}

variable "anywhere-cidr" {
  default = "0.0.0.0/0"
}

variable "Application-port" {
  default = "81"
}

variable "From-Port-Node-to-Node" {
  default = "0"
}

variable "To-Port-Node-to-Node" {
  default = "65535"
}
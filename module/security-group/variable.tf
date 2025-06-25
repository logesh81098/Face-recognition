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

variable "from-port-node-to-cluster" {
  default = "0"
}

variable "to-port-node-to-cluster" {
  default = "10250"
}
variable "project" {
  default = "terraform-321413"
}

variable "region" {
  default = "us-central1" 
}

variable "zone"  {
  default = "us-central1-c"
}

variable "vpc_name"  {
  default = "terraform-network-1"
}

variable "bucket" {
  default = "terraform-321413"
} 

variable "folder" {
  default = "state"
} 


variable "cidr_ip" {
  default = "10.0.0.0/16"
} 
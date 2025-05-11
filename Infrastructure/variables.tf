variable "instance_type" {
  description = "type of ami"
  type        = string
  default     = "t2.micro"

}
variable "ami_name" {
  description = "ami id of instance"
  type        = string
  default     = "ami-0f88e80871fd81e91"
}
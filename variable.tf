########### envioronment variables #########
/*variable "region" {
  description = "enter region name in which vpc to be creaated"
  type        = string
  default     = "us-east-1"
  */


variable "project" {
  description = "enter project name for which vpc to be creaated"
  type        = string
  default     = "Target"
}


variable "Env" {
  description = "enter the Environment name of project"
  type        = string
  default     = "Dev"
}





##### User variables #####

variable "cidr" {
  description = "enter cide value for VPC"
  type        = string
  default     = "192.168.0.0/16"
}

variable "public_subnet_1_cidr" {
  description = "enter cidr value for subnet-1"
  type        = string
  default     = "192.168.1.0/24"
}

variable "public_subnet_2_cidr" {
  description = "enter cidr value for subnet-2"
  type        = string
  default     = "192.168.2.0/24"
}

variable "database_subnet_1_cidr" {
  description = "enter cidr value for database subnet-1"
  type        = string
  default     = "192.168.5.0/24"
}

variable "database_subnet_2_cidr" {
  description = "enter cidr value for database subnet-2"
  type        = string
  default     = "192.168.6.0/24"
}

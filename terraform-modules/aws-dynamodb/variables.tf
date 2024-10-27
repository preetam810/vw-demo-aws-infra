variable "env_name" {
  type    = string
}

variable "shared_tags" {
  type   = map(string)
}

variable "table_name" {
  type    = string
  default = "employee"
}

variable "hash_key" {
  type    = string
  default = "emp_id"
}

variable "read_capacity" {
  type    = string
  default = "2"
}

variable "write_capacity" {
  type    = string
  default = "2"
}
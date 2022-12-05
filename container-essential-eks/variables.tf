# Project variable
variable "project" {
  description = "Name of the project"
  type        = string
  default     = "challenge"
}

# Kubernetes version
variable "eks_version" {
  description = "Version of Kubernetes"
  type        = string
}

# List of the public subnets
variable "public_subnets" {
  description = "Public Subnet IDs"
  type        = list(string)
}

# List of the private subnetes
variable "private_subnets" {
  description = "Private Subnet IDs"
  type        = list(string)
}

# Quantity of the node of group
variable "desired_size" {
  description = "Desired Size for Node Group"
  type        = number
}

# Max quantity of the node of group
variable "max_size" {
  description = "Max Size for Node Group"
  type        = number
}

# Min quantity of the node of group
variable "min_size" {
  description = "Min Disk Size for Node Group"
  type        = number
}

# Type of AMI associated with EKS
variable "ami_type" {
  description = "Type of Amazon Machine Image associated with the EKS Node Group."
  type        = string
}

# Disk size in GiB for workers nodes
variable "disk_size" {
  description = "Disk size in GiB for worker nodes."
  type        = string
}

# List of type of instances associate for worker nodes
variable "instance_types" {
  description = "List of instance types associated with the Node Group."
  type        = list(any)
}

# Type of Node Group capacity
variable "capacity_type" {
  description = "Capacity Type for EKS Node Group"
  type        = string
}

# Map of the tags
variable "tags" {
  description = "Mapping of tags to add to all resources."
  type        = map(string)
}

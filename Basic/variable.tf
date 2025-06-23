variable filename1 {
  type        = string
  default     = "sample.txt"
}

variable content_value{
    type = string
    default = "Hello World"
}

variable boolean_type {
  type        = bool
  default     = true
}

variable list_type {
  type        = list(string) 
  default     = ["red" , "blue" ,"green"]
}

variable tuple_type{
    type = tuple([string,number,bool])
    default = ["red" , 23 , true]
}

variable map_type {
  type        = map
  default     = {name : "yashwanth" , age : 21}
}

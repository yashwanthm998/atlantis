
resource local_file sample_res {

  filename = var.filename1
   content = var.content_value
  # content = var.boolean_type
  # content = var.list_type[2]
  # content = var.map_type["name"]
  #content = var.tuple_type[0]

}

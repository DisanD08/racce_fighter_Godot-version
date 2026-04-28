
##-Читаем файл-##
func read(file_name):
	var file = File.new()
	
	file.open("res://%s" %[file_name], File.READ)
	var data_json = parse_json(file.get_as_text())
	file.close()
	
	return data_json


##-Запись в файл-##
func write(file_name, data):
	var file = File.new()
	
	file.open("res://%s" %[file_name], File.WRITE)
	file.store_line(to_json(data))
	file.close()


##-Обновление данных-##
func update(file_name, key, new_value):
	var data_json = read(file_name)
	data_json[key] = new_value
	write(file_name, data_json)

##-Поис данных-##
func select(file_name, key):
	var data_json = read(file_name)
	var result = data_json[key]
	
	return result

func delete(file_name):
	var dir = Directory.new()
	dir.remove("res://%s" %[file_name])



extends ItemList

func _ready():
	add_item("Монетки:")
	
	var file = File.new()
	file.open("res://DB/data.in", File.READ)
	var info =  parse_json(file.get_as_text())
	file.close()
	
	for i in info.values():
		add_item( str(i[1]) )

extends ItemList

var rng = RandomNumberGenerator.new()

func _ready():
	add_item("Имя:")
	
	var file = File.new()
	file.open("res://DB/data.in", File.READ)
	var info =  parse_json(file.get_as_text())
	file.close()
	
	for i in info.keys():
		add_item(i)

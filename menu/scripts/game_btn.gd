extends Button

onready var name_line = get_node("name_line")
var dc = load("res://game/scripts/db_control.gd").new()

func _on_game_btn_pressed():
	var name = name_line.text
	
	if name == "": pass
	elif name == "DisanD_08" or name == "DD": print("fuck you")
	
	
	var player_money 
	var file = File.new()

	if file.file_exists("res://DB/%s.in" %[name]):
		file.open("res://DB/%s.in" %[name], File.READ)
		while not file.eof_reached():
			var data = parse_json(file.get_as_text())
			print(data)
			player_money = data['money']
		file.close()
	else: player_money = 0
	
	
	dc.write("INFO.in",
		{ "name": name,
		  "money": player_money,
		  "score": 0,
		  "player_life": 100,
		  "player_petrol": 100,
		  "speed": 200,
		  "cheker": 10,
		  "active_skin": "player_red" } )
	
	get_tree().change_scene("res://game.tscn")

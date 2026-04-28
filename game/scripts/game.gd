extends Node2D

export var mobUp_scene = preload("res://game/subscene/mob_up.tscn")
export var mobD_scene = preload("res://game/subscene/mob_down.tscn")
export var RKit_scene = preload("res://game/subscene/Repair_Kit.tscn")
export var Petrol_scene = preload("res://game/subscene/Petrol.tscn")

var dc = load("res://game/scripts/db_control.gd").new()

func _process(delta):
	var life = dc.select("INFO.in", "player_life")
	var petrol = dc.select("INFO.in", "player_petrol")
	
	if life <= 0: end_game()
	if petrol <= 0: end_game()

func score_counter(number):
	var score = int(dc.select("INFO.in", "score"))
	score += number
	dc.update("INFO.in", "score", score)
	
	if score >= int(dc.select("INFO.in", "cheker")):
		var cheker = dc.select("INFO.in", "cheker")
		dc.update("INFO.in", "cheker", cheker+10)
		
		var speed = dc.select("INFO.in", "speed")
		dc.update("INFO.in", "speed", speed+30)

func petrol_counter(number):
	var petrol = int(dc.select("INFO.in", "player_petrol"))
	petrol -= number
	dc.update("INFO.in", "player_petrol", petrol)

func end_game():
	queue_free()
	
	var file = File.new()
	var info = {"name": null, "score": null, "money": null}
	
	file.open("res://DB/data.in", File.READ)
	var fileList =  parse_json(file.get_as_text())
	file.close()
	
	info["name"] = dc.select("INFO.in", "name")
	info["score"] = dc.select("INFO.in", "score")
	info["money"] = dc.select("INFO.in", "money")
	
	if dc.select("INFO.in", "name") in fileList.keys(): pass
	else:
		file.open("res://DB/%s" %[dc.select("INFO.in", "name")+".in"], File.WRITE)
		file.store_line(to_json(info))
		file.close()
		
	dc.delete('INFO.in')
	
	get_tree().change_scene("res://menu.tscn")
	

##--------------------------------------------Таймеры------------------------------------------##
func _on_MobTimer_timeout():
	var mob = mobUp_scene.instance()

	var mob_spawn_location = get_node("MobUp_Path/MobUp_SpawnLocation")
	mob_spawn_location.offset = randi()

	mob.position = mob_spawn_location.position

# warning-ignore:unused_variable
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)

	add_child(mob)


func _on_MobD_Timer_timeout():
	var mobD = mobD_scene.instance()

	var mobD_spawn_location = get_node("MobD_Path/MobD_SpawnLocation")
	mobD_spawn_location.offset = randi()

	mobD.position = mobD_spawn_location.position

# warning-ignore:unused_variable
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)

	add_child(mobD)


func _on_RK_Timer_timeout():
	var RK = RKit_scene.instance()

	var RK_spawn_location = get_node("RK_Path/RK_SpawnLocation")
	RK_spawn_location.offset = randi()

	RK.position = RK_spawn_location.position

# warning-ignore:unused_variable
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)

	add_child(RK)
	

func _on_Petrol_Timer_timeout():
	var Petrol = Petrol_scene.instance()

	var Petrol_spawn_location = get_node("Petrol_Path/Petrol_SpawnLocation")
	Petrol_spawn_location.offset = randi()

	Petrol.position = Petrol_spawn_location.position

# warning-ignore:unused_variable
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)

	add_child(Petrol)
	
##----------------------------------------------------------------------------------------------##

extends Node

var scoreList = load("res://menu/scripts/score_tables.gd").new()

func _ready():
	OS.execute("python", ["start.py"], true)
	#print("go")
	
	scoreList.updateList()

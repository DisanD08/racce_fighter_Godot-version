extends Label

var dc = load("res://game/scripts/db_control.gd").new()
var player_name = dc.select("INFO.in", "name")

func _ready(): set_text( str(dc.select("DB/%s.in" %[player_name], "money")) )

extends Label

var dc = load("res://game/scripts/db_control.gd").new()

func _ready(): set_text( "Имя: %s" %[dc.select("INFO.in", "name")] )

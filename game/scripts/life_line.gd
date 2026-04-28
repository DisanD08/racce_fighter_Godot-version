extends Node2D

var dc = load("res://game/scripts/db_control.gd").new()

var rect
var color = Color(0, 1, 0)

func redact(): return Rect2(Vector2(655, 336), Vector2(21, dc.select("INFO.in", "player_life")))

func _draw():
	rect = redact()
	draw_rect(rect, color)

func _process(delta):
	update()

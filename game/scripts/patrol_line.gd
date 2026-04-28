extends Node2D

var dc = load("res://game/scripts/db_control.gd").new()

var rect
var color = Color(1, 0, 0)

func redact(): return Rect2(Vector2(621, 336), Vector2(21, dc.select("INFO.in", "player_petrol")))

func _draw():
	rect = redact()
	draw_rect(rect, color)

func _process(delta):
	update()

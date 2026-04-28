extends Node2D

var dc = load("res://game/scripts/db_control.gd").new()

var speed = dc.select("INFO.in", "speed") + 100
var velocity  = Vector2()
var screen_size

func _ready(): screen_size = get_viewport_rect().size
	
func get_input():
	velocity  = Vector2()

	velocity.y += speed

	velocity  = velocity.normalized() * speed
	
	if position.y >= 125: 
		position = Vector2(52, -4) 

func _process(delta):
	get_input()
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 38, screen_size.y)

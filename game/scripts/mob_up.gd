extends KinematicBody2D

var main = load("res://game/scripts/game.gd").new()
var dc = load("res://game/scripts/db_control.gd").new()

var speed = dc.select("INFO.in", "speed")
var velocity  = Vector2()
var screen_size

func _ready():
	screen_size = get_viewport_rect().size

func get_input():
	velocity  = Vector2()

	velocity.y -= speed

	velocity  = velocity.normalized() * speed
	
	if global_position.y <= 0:
		queue_free()
		main.score_counter(1)
		main.petrol_counter(2)

func _process(delta):
	get_input()
	velocity  = move_and_slide(velocity)

#	position += velocity * delta
#	position.x = clamp(position.x, 0, screen_size.x)
#	position.y = clamp(position.y, 38, screen_size.y)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _physics_process(delta):
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		
		if collision.collider.name == "Player":
			var life = dc.select("INFO.in", "player_life")

			if life - 12.5 <= 0: dc.update("INFO.in", "player_life", 0)
			else: dc.update("INFO.in", "player_life", life-12.5)
		queue_free()

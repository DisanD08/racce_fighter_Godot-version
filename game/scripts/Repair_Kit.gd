extends KinematicBody2D

var dc = load("res://game/scripts/db_control.gd").new()

var speed = 100
var velocity  = Vector2()
var screen_size

func disappearance(): 
	Vector2(0, 0)
	
func _ready():
	screen_size = get_viewport_rect().size

func get_input():
	velocity  = Vector2()

	velocity.y += speed		

	velocity  = velocity.normalized() * speed
	
	if global_position.y >= 450:
		queue_free()

func _process(delta):
	get_input()
	velocity  = move_and_slide(velocity)

#	position += velocity * delta
#	position.x = clamp(position.x, 0, screen_size.x)
#	position.y = clamp(position.y, 38, screen_size.y)


func _physics_process(delta):
	get_input()
	velocity  = move_and_slide(velocity)

	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 38, screen_size.y)
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		#print("I collided with ", collision.collider.name)
		
		if collision.collider.name == 'Player':
			var life = dc.select("INFO.in", "player_life")

			if life + 50 >= 100: dc.update("INFO.in", "player_life", 100)
			else: dc.update("INFO.in", "player_life", life+50)
		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

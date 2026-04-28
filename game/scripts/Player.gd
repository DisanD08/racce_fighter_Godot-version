extends KinematicBody2D

var l_l = load("res://game/scripts/life_line.gd").new()
var r_k = load("res://game/scripts/Repair_Kit.gd").new()
var dc = load("res://game/scripts/db_control.gd").new()

var speed = 150

var screen_size
var velocity  = Vector2()

func _ready(): 
	screen_size = get_viewport_rect().size
	
func get_input():
	velocity  = Vector2()
	set_rotation_degrees(0)

	if Input.is_action_pressed("player_left"):
		velocity .x -= speed
		set_rotation_degrees(-15)
	
	if Input.is_action_pressed("player_right"): 
		velocity .x += speed
		set_rotation_degrees(15)

	if Input.is_action_pressed("player_down"):
		velocity .y += speed

	if Input.is_action_pressed("player_up"):
		velocity .y -= speed

	velocity  = velocity .normalized() * speed

func _physics_process(delta):
	get_input()
	velocity  = move_and_slide(velocity)

	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 38, screen_size.y)
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		#print("I collided with ", collision.collider.name)

		if collision.collider.name == 'right_line' or collision.collider.name == 'left_line':
			var life = dc.select("INFO.in", "player_life")
			life -= 1
			dc.update("INFO.in", "player_life", life)

			l_l.redact()

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

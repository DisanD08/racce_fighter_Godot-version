extends CanvasLayer

var dc = load("res://game/scripts/db_control.gd").new()

onready var playerScore = $ScoreLabel

func update_score(): playerScore.set_text(str(dc.select("INFO.in", "score")))

func update_speed(): $SpeedLabel.set_text(str(dc.select("INFO.in", "speed")-180))

func nameLabel():
	var name = str(dc.select("INFO.in", "name"))
	$NameLabel.set_text(str(name))

func _ready():
	nameLabel()

func _process(delta):
	update_score()
	update_speed()

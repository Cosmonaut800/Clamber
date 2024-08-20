extends Area2D

@onready
var sign = $EnterSign

@export
var room_name : String 
var player_in_range := false

signal door_entered

# Called when the node enters the scene tree for the first time.
func _ready():
	sign.play()
	sign.visible = false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player_in_range:
		sign.visible = true
		if Input.is_action_just_pressed("move_up"):
			door_entered.emit()
	else:
		sign.visible = false
	
	return null


func _on_body_entered(body):
	if body.name == "Player":
		player_in_range = true


func _on_body_exited(body):
	if body.name == "Player":
		player_in_range = false

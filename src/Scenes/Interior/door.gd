extends Area2D

@onready
var sign = $EnterSign

@export
var room_name : String 
var player_in_range := false



# Called when the node enters the scene tree for the first time.
func _ready():
	sign.play()
	sign.visible = false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player_in_range:
		sign.visible = true
	else:
		sign.visible = false
	
	return null


func _on_body_entered(body):
	player_in_range = true


func _on_body_exited(body):
	player_in_range = false

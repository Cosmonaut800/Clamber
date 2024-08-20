extends Area2D

@onready var direction_animations = $direction_animations
@onready var shield_generator_animation = $ShieldGenerator

var player_there := false
var pressed_up := false
# Called when the node enters the scene tree for the first time.
func _ready():
	
	direction_animations.hide()
	if Global.shield < Global.MAX_SHIELD:
		direction_animations.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Global.shield <= 0:
		shield_generator_animation.stop()
	else:
		shield_generator_animation.play("working")
	
	if Global.shield < Global.MAX_SHIELD:
		if pressed_up:
			direction_animations.play("press_down")
		else:
			direction_animations.play("press_up")
		
		if player_there and not pressed_up and Input.is_action_just_pressed("move_up"):
			pressed_up = true
			Global.shield += 4
		
		if player_there and pressed_up and Input.is_action_just_pressed("move_down"):
			pressed_up = false
			Global.shield += 4
	else:
		direction_animations.hide()	


func _on_body_entered(body):
	if body.name == "Player":
		player_there = true
	if player_there:
		print("Im here!")


func _on_body_exited(body):
	if body.name == "Player":
		player_there = false
	if !player_there:
		print("I'm not here.")

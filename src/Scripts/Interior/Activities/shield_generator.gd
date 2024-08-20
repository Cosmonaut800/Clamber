extends Area2D

@onready var direction_animations = $direction_animations
@onready var shield_generator_animation = $ShieldGenerator
@onready var crank_up_sfx = $AudioStreamPlayerCrankUp
@onready var crank_down_sfx = $AudioStreamPlayerCrankDown
@onready var shield_pulsate = $AudioStreamPlayerPulsate

var player_there := false
var pressed_up := false
# Called when the node enters the scene tree for the first time.
func _ready():
	
	direction_animations.hide()
	#if Global.shield < Global.MAX_SHIELD:
	#	direction_animations.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.shield < Global.MAX_SHIELD:
		direction_animations.show()
	
	if Global.shield <= 0:
		shield_generator_animation.stop()
		if shield_pulsate.playing:
			shield_pulsate.stop()
	else:
		shield_generator_animation.play("working")
		if not shield_pulsate.playing:
			shield_pulsate.play()
	
	if Global.shield < Global.MAX_SHIELD:
		if pressed_up:
			direction_animations.play("press_down")
		else:
			direction_animations.play("press_up")
		
		if player_there and not pressed_up and Input.is_action_just_pressed("move_up"):
			crank_up_sfx.play()
			pressed_up = true
			Global.shield += 4
		
		if player_there and pressed_up and Input.is_action_just_pressed("move_down"):
			crank_down_sfx.play()
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

extends Area2D

@onready
var interaction_sign = $InteractionSign
@onready
var player = get_parent().get_node("Player")
@onready
var reactor_engine_sign = get_parent().get_node("ReactorEngine").get_node("InteractionSign")
@onready
var drop_off_sfx = $AudioStreamPlayerDropOff

var player_in_range = false
var dropped_off_old_rod = false

# Called when the node enters the scene tree for the first time.
func _ready():
	dropped_off_old_rod = false
	interaction_sign.hide()
	interaction_sign.play("hover")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if player.has_old_rad_rod || dropped_off_old_rod:
		interaction_sign.show()
	else:	
		interaction_sign.hide()
		
	if player_in_range and player.has_old_rad_rod and not dropped_off_old_rod and Input.is_action_just_pressed("interact"):
		drop_off_sfx.play()
		interaction_sign.hide()
		player.has_old_rad_rod = false
		player.has_new_rad_rod = false
		dropped_off_old_rod = true
		
	if player_in_range and dropped_off_old_rod and Input.is_action_just_pressed("interact"):
			drop_off_sfx.play()
			player.has_new_rad_rod = true
			dropped_off_old_rod = false
		


func _on_body_entered(body):
	if body.name == "Player":
		player_in_range = true


func _on_body_exited(body):
	if body.name == "Player":
		player_in_range = false

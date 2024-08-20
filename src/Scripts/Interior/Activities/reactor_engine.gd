extends Area2D

@onready
var player = get_parent().get_node("Player")
@onready
var interaction_sign = $InteractionSign
@onready
var rad_rod = $RadRod
@onready
var timer = $Timer
@onready
var rad_rod_shelf_sign = get_parent().get_node("ReactorRodShelf").get_node("InteractionSign")
@onready
var pick_up_rad_rod_sfx = $AudioStreamPlayerPickUpRod

var player_in_range := false

# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_sign.hide()
	interaction_sign.play("hover")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.fuel < Global.MAX_FUEL and timer.time_left == 0 and not player.has_old_rad_rod or player.has_new_rad_rod:
		interaction_sign.show()
	else:
		interaction_sign.hide()
	
	if player_in_range and not player.has_old_rad_rod and not player.has_new_rad_rod and Input.is_action_just_pressed("interact") and timer.is_stopped():
		pick_up_rad_rod_sfx.play()
		player.has_old_rad_rod = true
		rad_rod.hide()
	
	if player_in_range and player.has_new_rad_rod and Input.is_action_just_pressed("interact"):
		pick_up_rad_rod_sfx.play()
		player.has_new_rad_rod = false
		rad_rod.show()
		Global.fuel = Global.MAX_FUEL
		timer.start()

func _on_body_entered(body):
	if body.name == "Player":
		player_in_range = true

func _on_body_exited(body):
	if body.name == "Player":
		player_in_range = false

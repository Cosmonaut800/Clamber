extends Area2D

@onready var player = get_parent().get_node("Player")
@onready var interaction_sign = $InteractionSign
@onready var pick_up_sfx = $AudioStreamPlayerPickUpBullets
var player_in_range = false

# Called when the node enters the scene tree for the first time.
func _ready():
	player_in_range = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.ammo < Global.MAX_AMMO and not player.has_ammo:
		interaction_sign.show()
		interaction_sign.play("hover")
		
		if player_in_range and Input.is_action_just_pressed("interact"):
			pick_up_sfx.play()
			player.has_ammo = true
		
	else:
		interaction_sign.hide()


func _on_body_entered(body):
	if body.name == "Player":
		player_in_range = true


func _on_body_exited(body):
	if body.name == "Player":
		player_in_range = false

extends Area2D

@onready
var player = get_parent().get_node("Player")
@onready
var interaction_sign = $InteractionSign
var player_in_range = false

# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_sign.hide()
	interaction_sign.play("hover")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.ammo < Global.MAX_AMMO:
		if player.has_ammo:
			interaction_sign.show()
		if player_in_range and Input.is_action_just_pressed("interact"):
			interaction_sign.hide()
			Global.ammo += 30.0
			if Global.ammo > Global.MAX_AMMO:
				Global.ammo = Global.MAX_AMMO
			player.has_ammo = false
	


func _on_body_entered(body):
	if body.name == "Player":
		player_in_range = true


func _on_body_exited(body):
	if body.name == "Player":
		player_in_range = false

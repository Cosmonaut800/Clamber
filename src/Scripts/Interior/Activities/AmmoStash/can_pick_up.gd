extends State

@export var idle_state : State
@export var player_has_ammo_state : State
@onready var ammo_stash := $"../.."
@onready var pick_up_sfx := $"../../AudioStreamPlayerPickUpBullets"
func enter() -> void:
	ammo_stash.interaction_sign.show()
		
func process_input(_event: InputEvent) -> State:
	if ammo_stash.player_there and Input.is_action_just_pressed("interact"):
		pick_up_sfx.play()
		ammo_stash.turret_butt.set_ready_to_load(true)
		return player_has_ammo_state
	return null

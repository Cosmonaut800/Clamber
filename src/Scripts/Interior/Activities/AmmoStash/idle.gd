extends State

@export var can_pick_up_state : State
@onready var ammo_stash := $"../.."
func enter() -> void:
	ammo_stash.interaction_sign.hide()

func process_input(_event: InputEvent) -> State:
	if Global.ammo < Global.MAX_AMMO:
		return can_pick_up_state
	return null

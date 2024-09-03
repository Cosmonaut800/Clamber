extends State

@export var idle_state : State
@onready var ammo_stash := $"../.."

func enter() -> void:
	ammo_stash.interaction_sign.hide()

func process_input(_event: InputEvent) -> State:
	if ammo_stash.turret_butt.get_ready_to_load() == false:
		return idle_state
	return null

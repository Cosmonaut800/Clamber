extends State

@export var drop_off_state : State
@onready var turret_butt := $"../.."
@onready var interaction_s

func enter() -> void:
	turret_butt.interaction_sign.hide()
	pass

func process_input(_event: InputEvent) -> State:
	if turret_butt.ready_to_load:
		return drop_off_state
	return null

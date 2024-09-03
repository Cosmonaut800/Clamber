extends State

@export var press_up_state : State
@onready var direction_animations = $"../../direction_animations"

func enter() -> void:
	direction_animations.hide()
func exit() -> void:
	direction_animations.show()

func process_input(_event: InputEvent) -> State:
	if Global.shield < Global.MAX_SHIELD:
		return press_up_state
	return null

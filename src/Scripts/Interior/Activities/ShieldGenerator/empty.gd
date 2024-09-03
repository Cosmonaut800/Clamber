extends State
@onready var direction_animations = $"../../direction_animations"
@onready var shield_generator = $"../.."
@onready var crank_down_sfx = $"../../AudioStreamPlayerCrankDown"
@export var down_state: State

func enter() -> void:
	direction_animations.play("press_up")

func process_input(_event: InputEvent) -> State:
	if shield_generator.player_there and Input.is_action_just_pressed("move_up"):
		crank_down_sfx.play()
		Global.shield += 4
		return down_state
	return null

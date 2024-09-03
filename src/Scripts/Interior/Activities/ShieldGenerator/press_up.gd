extends State

@onready var shield_generator := $"../.."
@onready var direction_animations := $"../../direction_animations"
@onready var crank_down_sfx := $"../../AudioStreamPlayerCrankDown"

@export var press_down_state : State
@export var empty_state : State
@export var full_state : State

func enter() -> void:
	direction_animations.play("press_up")

func process_input(_event: InputEvent) -> State:
	if Global.shield >= Global.MAX_SHIELD:
		Global.shield = Global.MAX_SHIELD
		return full_state
	
	if Global.shield <= 0.0:
		return empty_state
		
	if shield_generator.player_there and Input.is_action_just_pressed("move_up"):
		crank_down_sfx.play()
		Global.shield += 4
		return press_down_state
	
	return null

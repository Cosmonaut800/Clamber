extends State

@export
var idle_state: State
@export
var jump_state: State
@export
var fall_state: State
@onready var climbing_sfx = $"../../AudioStreamPlayerClimbing"
func enter() -> void:
	super()
	parent.velocity.x = 0
	move_speed = 100

func exit() -> void:
	if climbing_sfx.playing:
		climbing_sfx.stop()

func process_input(_event: InputEvent) -> State:
	if Input.is_action_just_pressed("jump"):
		return jump_state
	return null

func process_physics(_delta: float) -> State:
	
		
	var input = Input.get_axis("move_up","move_down")
	var movement = input * move_speed

	parent.velocity.y = movement

	parent.move_and_slide()
	
	if input == 0:
		parent.animation_player.stop()
		if climbing_sfx.playing:
			climbing_sfx.stop()
	else:
		parent.animation_player.play()
		if not climbing_sfx.playing:
			climbing_sfx.play()

	if parent.is_on_floor():
		return idle_state
	
	if !parent.in_ladder_area and !parent.is_on_floor():
		return fall_state
	
	
	return null

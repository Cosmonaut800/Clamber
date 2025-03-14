extends State

@export
var idle_state: State
@export
var jump_state: State
@export
var fall_state: State
@export
var climb_state: State

@onready var walking_sfx = $"../../AudioStreamPlayerWalking"



var prevInput


func enter() -> void:
	super()
	parent.jump_force = 300
	parent.velocity.x = 0

func exit() -> void:
	parent.velocity.x = 0
	if walking_sfx.playing:
		walking_sfx.stop()

func process_input(_event: InputEvent) -> State:
	if Input.is_action_just_pressed("jump") and parent.is_on_floor():
		return jump_state
	
	if Input.is_action_just_pressed("move_up") and parent.in_ladder_area:
		return climb_state
	
	return null


func process_physics(_delta: float) -> State:
	if !walking_sfx.playing:
		walking_sfx.play()
	parent.velocity.y += gravity * _delta
	
	var input = Input.get_axis("move_left","move_right")
	var movement = input * move_speed
	
	if movement != 0:
		parent.animation_player.flip_h = movement < 0
	
	parent.velocity.x = movement
	#set floor snapping for sloped surfaces
	parent.set_floor_snap_length(30)
	parent.apply_floor_snap()
	parent.move_and_slide()
	
	
	if  movement == 0:
		return idle_state
	
	if !parent.is_on_floor():
		return fall_state
	
	return null

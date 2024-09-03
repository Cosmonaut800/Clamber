extends State

@onready var turret_butt := $"../.."
@onready var drop_off_sfx := $"../../AudioStreamPlayerDropOff"
@export var idle_state : State

# Called when the node enters the scene tree for the first time.
func enter() -> void:
	turret_butt.interaction_sign.show()
	
func exit() -> void:
	turret_butt.set_ready_to_load(false)
	
func process_input(_event: InputEvent) -> State:
	if Global.ammo  == Global.MAX_AMMO:
		return idle_state
		
	if turret_butt.player_there and Input.is_action_just_pressed("interact"):
		drop_off_sfx.play()
		Global.ammo += 30
		if Global.ammo >= Global.MAX_AMMO:
			Global.ammo = Global.MAX_AMMO
		return idle_state
	return null

extends Interactable
@onready
var player = get_parent().get_node("Player")
@onready
var interaction_sign = $InteractionSign
@onready var drop_off_sfx = $AudioStreamPlayerDropOff
var ready_to_load := false

#states
#disabled - player hasn't picked up ammo yet
#enabled - player is holding ammo and can interact with turret butt
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.ammo = 0.0
	interaction_sign.play("hover")
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
	
func _process(delta: float) -> void:
	state_machine.process_frame(delta)
	
func _on_body_entered(body):
	if body.name == "Player":
		player_there = true

func _on_body_exited(body):
	if body.name == "Player":
		player_there = false

func set_ready_to_load(value : bool):
	self.ready_to_load = value

func get_ready_to_load():
	return self.ready_to_load

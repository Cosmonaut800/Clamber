extends Interactable

# Called when the node enters the scene tree for the first time.
@onready var interaction_sign := $InteractionSign
@export var turret_butt : Interactable
#states
#turret ammo full - player can't interact with ammo stash
#turret ammo less than full
	#enabled - can player can grab ammo
	#disabled - player is already holding ammo

func _ready() -> void:
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

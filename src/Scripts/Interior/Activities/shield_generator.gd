extends Interactable

@onready var shield_generator_animation = $ShieldGenerator
@onready var shield_pulsate = $AudioStreamPlayerPulsate

var player_there := false
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	Global.shield = 0.0
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
	
func _process(delta: float) -> void:
	if Global.shield <= 0.0:
		shield_generator_animation.stop()
		if shield_pulsate.playing:
			shield_pulsate.stop()
	else:
		shield_generator_animation.play("working")
		if not shield_pulsate.playing:
			shield_pulsate.play()
	state_machine.process_frame(delta)

func _on_body_entered(body):
	if body.name == "Player":
		player_there = true

func _on_body_exited(body):
	if body.name == "Player":
		player_there = false

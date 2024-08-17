extends Node2D

@onready var large_robot := $LargeRobot
@onready var healthbar := $HealthBar
@onready var shieldbar := $ShieldBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	healthbar.set_value_no_signal(large_robot.health)
	shieldbar.set_value_no_signal(large_robot.shield)

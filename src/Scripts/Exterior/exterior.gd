extends Node2D

const DISTANCE_FACTOR := 10.0

@onready var large_robot := $LargeRobot
@onready var lava := $Lava
@onready var healthbar := $UI/HealthBar
@onready var shieldbar := $UI/ShieldBar
@onready var fuelbar := $UI/FuelBar
@onready var ammobar := $UI/AmmoBar
@onready var distancebar := $UI/DistanceBar
@onready var you_marker := $UI/DistanceMeter/YouMarker
@onready var danger_marker := $UI/DistanceMeter/DangerMarker

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	healthbar.set_value_no_signal(Global.health)
	shieldbar.set_value_no_signal(Global.shield)
	fuelbar.set_value_no_signal(Global.fuel)
	ammobar.set_value_no_signal(Global.ammo)
	you_marker.position.y = 248.0 - large_robot.distance_climbed / DISTANCE_FACTOR
	distancebar.value = (large_robot.distance_climbed - lava.position.y + 270.0) / DISTANCE_FACTOR
	danger_marker.position.y = 251.0 - distancebar.value

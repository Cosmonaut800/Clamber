extends Node2D

# The maximum distance traveled before reaching the top of the meter will be
# PLAYER_INDICATOR_OFFSET * DISTANCE_FACTOR
const PLAYER_INDICATOR_OFFSET = 251.0
const DISTANCE_FACTOR := 10.0

@onready var cockpit := $Cockpit
@onready var large_robot := $LargeRobot
@onready var lava := $Lava
@onready var healthbar := $UI/HealthBars/HealthBar
@onready var shieldbar := $UI/HealthBars/ShieldBar
@onready var fuelbar := $UI/HealthBars/FuelBar
@onready var ammobar := $UI/HealthBars/AmmoBar
@onready var distancebar := $UI/DistanceBar
@onready var you_marker := $UI/DistanceMeter/YouMarker
@onready var danger_marker := $UI/DistanceMeter/DangerMarker
@onready var spawn_timer := $SpawnTimer
@onready var animation_tree := $LargeRobot/Camera2D/AnimationTree

var enemy_template := preload("res://src/Scenes/Enemy/enemy.tscn")
var enemies: Array[RigidBody2D] = []

signal door_entered
signal died
signal won

func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	healthbar.set_value_no_signal(Global.health)
	shieldbar.set_value_no_signal(Global.shield)
	fuelbar.set_value_no_signal(Global.fuel)
	ammobar.set_value_no_signal(Global.ammo)
	you_marker.position.y = 248.0 - large_robot.distance_climbed / DISTANCE_FACTOR
	distancebar.value = (large_robot.distance_climbed - lava.position.y + 270.0) / DISTANCE_FACTOR
	danger_marker.position.y = 251.0 - distancebar.value
	
	Global.distance_bar_value = distancebar.value
	Global.you_marker_position = you_marker.position.y
	Global.danger_marker_position = danger_marker.position.y
	
	if large_robot.distance_climbed > DISTANCE_FACTOR * PLAYER_INDICATOR_OFFSET:
		won.emit()

func spawn_enemies(number: int, spawn_position: Vector2, initial_direction: Vector2 = Vector2.ZERO):
	for i in number:
		enemies.append(enemy_template.instantiate())
		enemies[-1].position = spawn_position
		enemies[-1].apply_impulse(100.0 * initial_direction.normalized())
		add_child(enemies[-1])
	
	large_robot.add_enemies(enemies)

func kill_enemy(index: int = 0):
	enemies[index].queue_free()
	enemies.remove_at(index)

func _on_spawn_timer_timeout() -> void:
	spawn_timer.wait_time = randf_range(4.0, 8.0)
	spawn_timer.start()
	if enemies.size() < 5 and lava.started:
		spawn_enemies(randi_range(2, 5), Vector2(176 + randf_range(-50.0, 50.0), 0), Vector2.DOWN)

func _on_cockpit_button_activated(index: int) -> void:
	match index:
		cockpit.BUTTON.UL:
			large_robot.move_upper_left_leg()
		cockpit.BUTTON.UR:
			large_robot.move_upper_right_leg()
		cockpit.BUTTON.DL:
			large_robot.move_lower_left_leg()
		cockpit.BUTTON.DR:
			large_robot.move_lower_right_leg()

func activate_exterior():
	lava.started = true
	cockpit.player.set_process_mode(Node.PROCESS_MODE_INHERIT)
	cockpit.door.set_process_mode(Node.PROCESS_MODE_INHERIT)
	AudioServer.get_bus_effect(AudioServer.get_bus_index("Exterior SFX"), 0).cutoff_hz = 20500.0

func deactivate_exterior():
	cockpit.player.set_process_mode(Node.PROCESS_MODE_DISABLED)
	cockpit.door.set_process_mode(Node.PROCESS_MODE_DISABLED)
	cockpit.player.set_global_position(cockpit.door_marker.global_position)
	AudioServer.get_bus_effect(AudioServer.get_bus_index("Exterior SFX"), 0).cutoff_hz = 500.0

func _on_cockpit_door_entered() -> void:
	door_entered.emit()

func _on_large_robot_died() -> void:
	died.emit()

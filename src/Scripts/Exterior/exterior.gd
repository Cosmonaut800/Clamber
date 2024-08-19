extends Node2D

# The maximum distance traveled before reaching the top of the meter will be
# PLAYER_INDICATOR_OFFSET * DISTANCE_FACTOR
const PLAYER_INDICATOR_OFFSET = 251.0
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
@onready var spawn_timer := $SpawnTimer

var enemy_template := preload("res://src/Scenes/Enemy/enemy.tscn")
var enemies: Array[RigidBody2D] = []

func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	healthbar.set_value_no_signal(large_robot.health)
	shieldbar.set_value_no_signal(large_robot.shield)
	fuelbar.set_value_no_signal(large_robot.fuel)
	ammobar.set_value_no_signal(large_robot.ammo)
	you_marker.position.y = 244.0 - large_robot.distance_climbed / DISTANCE_FACTOR
	distancebar.value = (large_robot.distance_climbed - lava.position.y + 270.0) / DISTANCE_FACTOR
	danger_marker.position.y = 251.0 - distancebar.value

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
	#large_robot.remove_enemy(index)

func _on_spawn_timer_timeout() -> void:
	spawn_timer.wait_time = randf_range(4.0, 8.0)
	spawn_timer.start()
	if enemies.size() < 5:
		spawn_enemies(randi_range(2, 5), Vector2(176 + randf_range(-50.0, 50.0), 0), Vector2.DOWN)

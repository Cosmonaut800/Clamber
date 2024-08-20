extends Node2D

@export var large_robot: Node2D

@onready var bullets := $Bullets
@onready var kill_timer := $KillTimer
@onready var death_sfx = $AudioStreamPlayerEnemyDeath
@onready var firing_sfx = $AudioStreamPlayerFiring
var is_firing := false
var enemies: Array[RigidBody2D] = []
var target_rotation := 0.0

signal kill_enemy(index: int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var rotation_delta := 0.0
	
	if enemies:
		target_rotation = global_position.direction_to(enemies[0].global_position).angle() + PI/2.0
		
		if target_rotation - rotation < 0.1 and Global.ammo > 0.0 and not large_robot.dead:
			if kill_timer.is_stopped():
				kill_timer.start()
			is_firing = true
			bullets.set_emitting(true)
		else:
			if not kill_timer.is_stopped():
				kill_timer.stop()
			is_firing = false
			bullets.set_emitting(false)
	else:
		is_firing = false
		bullets.set_emitting(false)
	
	if is_firing:
		if not firing_sfx.playing:
			firing_sfx.pitch_scale = randf_range(0.95, 1.0)
			firing_sfx.play()
	
	if target_rotation > 2.0*PI:
		target_rotation -= 2.0*PI
	elif target_rotation < 0.0:
		target_rotation += 2.0*PI
	
	if rotation > 2.0*PI:
		rotation -= 2.0*PI
	elif rotation < 0.0:
		rotation += 2.0*PI
	
	if target_rotation > 1.667*PI and rotation < 0.5*PI:
		target_rotation -= 2.0*PI
	elif target_rotation < 0.5*PI and rotation > 1.667*PI:
		target_rotation += 2.0*PI
	
	rotation += 0.1 * (target_rotation - rotation)
	

func _on_kill_timer_timeout() -> void:
	death_sfx.pitch_scale = randf_range(0.9, 1.1)
	death_sfx.play()
	kill_enemy.emit(0)

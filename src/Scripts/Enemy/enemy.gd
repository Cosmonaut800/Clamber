extends RigidBody2D

const ROBOT_POSITION := Vector2(176.0, 135.0)
@onready var ram_sfx = $AudioStreamPlayerRam

@onready var graphics := $Graphics

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	apply_impulse(Vector2(randf_range(-80.0, 80.0), randf_range(-80.0, 80.0)))
	graphics.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	var force := 100.0 * (ROBOT_POSITION - global_position).normalized()
	
	apply_central_force(force)

func _on_body_entered(body: Node) -> void:
	ram_sfx.play()
	if body.collision_layer == 1:
		apply_impulse(100.0 * (global_position - body.global_position).normalized())
		body.deal_damage(2.0)

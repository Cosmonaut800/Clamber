extends TextureRect

const SCREEN_SIZE := Vector2(480.0, 270.0)
@onready var interior := $"../Interior"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position = interior.player_camera.global_position - (0.5 * SCREEN_SIZE)

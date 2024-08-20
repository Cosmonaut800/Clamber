extends Node2D
@onready
var rad_rod = $RadRod
# Called when the node enters the scene tree for the first time.
func _ready():
	rad_rod.set_animation("rad_rod_states")
	rad_rod.set_frame(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.fuel <= 0:
		rad_rod.set_frame(1)
	else:
		rad_rod.set_frame(0)

extends Node2D

@onready
var scene_transition_animator = $SceneTransition/AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	scene_transition_animator.play("fade_out")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

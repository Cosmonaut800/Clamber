extends Area2D

@onready
var sign = $EnterSign

@onready
var scene_transition = get_parent().find_child("SceneTransition")
@onready
var scene_transition_animator = scene_transition.find_child("AnimationPlayer")
@export
var room_name : String 
var player_in_range := false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	sign.visible = false
	sign.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player_in_range:
		sign.visible = true
		if Input.is_action_just_pressed("move_up"):
			scene_transition_animator.play("fade_in")
			await get_tree().create_timer(0.25).timeout 
			var scene_path = preload("res://src/Scenes/Interior/TurretBay.tscn").instantiate()
			get_tree().root.queue_free()
			get_tree().root.add_child(scene_path)
	else:
		sign.visible = false
	
	return null


func _on_body_entered(body):
	player_in_range = true


func _on_body_exited(body):
	player_in_range = false

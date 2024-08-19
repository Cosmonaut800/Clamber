extends Node2D
@onready var player := $Player
@onready var player_camera := $PlayerCamera

func _ready() -> void:
	Global.player = player
	Global.camera = player_camera

func activate_interior():
	pass

func deactivate_interior():
	pass

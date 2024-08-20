extends Node2D

@onready var player := $Player
@onready var player_camera := $PlayerCamera
@onready var door := $Door
@onready var door_marker := $DoorMarker
@onready var gui_overlay := $GUIOverlay

signal door_entered

func _ready() -> void:
	Global.player = player
	Global.camera = player_camera

func activate_interior():
	player.set_process_mode(Node.PROCESS_MODE_INHERIT)
	door.set_process_mode(Node.PROCESS_MODE_INHERIT)
	gui_overlay.visible = !gui_overlay.visible

func deactivate_interior():
	player.set_process_mode(Node.PROCESS_MODE_DISABLED)
	door.set_process_mode(Node.PROCESS_MODE_DISABLED)
	player.set_global_position(door_marker.global_position)

func _on_door_door_entered() -> void:
	door_entered.emit()

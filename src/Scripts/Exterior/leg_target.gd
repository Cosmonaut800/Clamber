extends Node2D


func _input(event):
	if event is InputEventMouseMotion:
		global_position = event.position

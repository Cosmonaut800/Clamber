extends Node2D

@onready var interior := $Interior
@onready var exterior := $SubViewportContainer/SubViewport/Exterior
@onready var animation_tree := $TextureRect/AnimationTree
@onready var ending := $CanvasLayer/Ending

var you_won := false
var died := false

func _on_interior_door_entered() -> void:
	animation_tree.set("parameters/conditions/fade_in", true)
	animation_tree.set("parameters/conditions/fade_out", false)
	exterior.animation_tree.set("parameters/conditions/zoom_out", true)
	exterior.animation_tree.set("parameters/conditions/zoom_in", false)

func _on_exterior_door_entered() -> void:
	animation_tree.set("parameters/conditions/fade_in", false)
	animation_tree.set("parameters/conditions/fade_out", true)
	exterior.animation_tree.set("parameters/conditions/zoom_out", false)
	exterior.animation_tree.set("parameters/conditions/zoom_in", true)

func _on_exterior_died() -> void:
	ending.play_losing_animation()

func _on_exterior_won() -> void:
	ending.play_winning_animation()

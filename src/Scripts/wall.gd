extends Node2D

#The X coordinates of the visible surface of the walls, used for placing scaffolds.
const LEFT_WALL_X := 128
const RIGHT_WALL_X := 352

@onready var graphics := $Graphics

var scaffold_template := preload("res://Scenes/scaffold.tscn")
var distance_climbed := 0.0

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	graphics.position.y = fmod(distance_climbed, get_viewport().get_visible_rect().size.y)
	distance_climbed += 100.0 * delta

extends Node2D

#The X coordinates of the visible surface of the walls, used for placing scaffolds.
const LEFT_WALL_X := 128.0
const RIGHT_WALL_X := 352.0
const SCAFFOLDS_PER_WALL := 3

@onready var graphics := $Graphics
@onready var left_scaffolds: Array = [	$Scaffolds/Scaffold1,
										$Scaffolds/Scaffold2,
										$Scaffolds/Scaffold3,
										$Scaffolds/Scaffold4,
										$Scaffolds/Scaffold5]
@onready var right_scaffolds: Array = [	$Scaffolds/Scaffold6,
										$Scaffolds/Scaffold7,
										$Scaffolds/Scaffold8,
										$Scaffolds/Scaffold9,
										$Scaffolds/Scaffold10]

var distance_climbed := 0.0
var distance_delta := 0.0
var scaffold_range := 1.0

func _ready() -> void:
	scaffold_range = get_viewport().get_visible_rect().size.y / SCAFFOLDS_PER_WALL
	
	for i in left_scaffolds.size():
		left_scaffolds[i].global_position.x = LEFT_WALL_X
		left_scaffolds[i].set_graphics(randi_range(0, left_scaffolds[i].graphics.size()-1))
		left_scaffolds[i].global_position.y = place_scaffold(i)
	
	for i in right_scaffolds.size():
		right_scaffolds[i].global_position.x = RIGHT_WALL_X
		right_scaffolds[i].set_graphics(randi_range(0, right_scaffolds[i].graphics.size()-1))
		right_scaffolds[i].global_position.y = place_scaffold(i)
		right_scaffolds[i].scale.x = -1.0

func _process(delta: float) -> void:
	graphics.position.y = fmod(distance_climbed, get_viewport().get_visible_rect().size.y)
	
	for scaffold in left_scaffolds:
		scaffold.position.y += distance_delta
		if scaffold.position.y > get_viewport().get_visible_rect().size.y + scaffold_range:
			scaffold.position.y = place_scaffold(left_scaffolds.size()-1)
			scaffold.randomize_anchor(scaffold_range/4.0)
			scaffold.set_graphics(randi_range(0, scaffold.graphics.size()-1))
	
	for scaffold in right_scaffolds:
		scaffold.position.y += distance_delta
		if scaffold.position.y > get_viewport().get_visible_rect().size.y + scaffold_range:
			scaffold.position.y = place_scaffold(right_scaffolds.size()-1)
			scaffold.randomize_anchor(scaffold_range/4.0)
			scaffold.set_graphics(randi_range(0, scaffold.graphics.size()-1))
	

func place_scaffold(region: int) -> float:
	return get_viewport().get_visible_rect().size.y - (region * scaffold_range) - (scaffold_range / 2.0)

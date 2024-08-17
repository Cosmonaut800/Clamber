extends Node2D

const EPS = 0.001

@onready var root_segment := $Segment1
@onready var target := $Target

var child_segments: Array = []

func _ready():
	child_segments = root_segment.get_children()
	while child_segments[-1].get_children():
		child_segments.append_array(child_segments[-1].get_children())

func _process(_delta):
	var a := 0.0
	var c := 0.0
	var d := 0.0
	var k := 0.0
	
	var x := 0.0
	var y := 0.0
	
	var head := Vector2.ZERO
	var tail := Vector2.ZERO
	
	if target.position.y < 0.0:
		tail = target.position * global_scale.x
	else:
		head = target.position * global_scale.x
	
	d = (0.8) * (tail.x - head.x)
	k = 1.0 - ((tail.x-d)/(head.x-d+EPS)) * ((tail.x-d)/(head.x-d+EPS))
	a = (head.y - tail.y)/(k * (head.x-d) * (head.x-d)+EPS)
	c = tail.y - a * (tail.x - d) * (tail.x - d)
	
	for i in range(child_segments.size()):
		x = ((i+1.0)/child_segments.size()) * target.position.x * global_scale.x
		y = a * (x - d) * (x - d) + c
		child_segments[i].global_position.x = x + global_position.x
		child_segments[i].global_position.y = y + global_position.y

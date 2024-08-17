extends Node2D

const EPS = 0.001

@export_enum("Left", "Right") var chirality: String = "Left"

@onready var root_segment := $Segment1
@onready var anim_target := $AnimationTarget #Where the leg segments end up on this frame
@onready var leg_target := $LegTarget #Where the leg is ultimately trying to go

var child_segments: Array = []
var target_scaffold := 0

func _ready() -> void:
	child_segments = root_segment.get_children()
	while child_segments[-1].get_children():
		child_segments.append_array(child_segments[-1].get_children())

func _process(delta: float) -> void:
	var leg_displacement: Vector2 = leg_target.position - anim_target.position
	anim_target.position = anim_target.position + 10.0*leg_displacement*delta
	
	draw_leg_segments()

func draw_leg_segments():
	var a := 0.0
	var c := 0.0
	var d := 0.0
	var k := 0.0
	
	var x := 0.0
	var y := 0.0
	
	var head := Vector2.ZERO
	var tail := Vector2.ZERO
	
	if anim_target.position.y < 0.0:
		tail = anim_target.position * global_scale.x
	else:
		head = anim_target.position * global_scale.x
	
	d = (0.8) * (tail.x - head.x)
	k = 1.0 - ((tail.x-d)/(head.x-d+EPS)) * ((tail.x-d)/(head.x-d+EPS))
	a = (head.y - tail.y)/(k * (head.x-d) * (head.x-d)+EPS)
	c = tail.y - a * (tail.x - d) * (tail.x - d)
	
	for i in child_segments.size():
		x = ((i+1.0)/child_segments.size()) * anim_target.position.x * global_scale.x
		y = a * (x - d) * (x - d) + c
		child_segments[i].global_position.x = x + global_position.x
		child_segments[i].global_position.y = y + global_position.y

extends Node2D

@export var wall: Node2D

@onready var upper_left_leg := $LargeRobotLegUL
@onready var upper_right_leg := $LargeRobotLegUR
@onready var lower_left_leg := $LargeRobotLegDL
@onready var lower_right_leg := $LargeRobotLegDR

var target_position := Vector2.ZERO
var distance_climbed := 0.0
var distance_delta := Vector2.ZERO

var timer := 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	upper_left_leg.target_scaffold = 1
	upper_right_leg.target_scaffold = 1
	lower_left_leg.target_scaffold = 0
	lower_right_leg.target_scaffold = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer += delta
	
	target_position = 0.25*upper_left_leg.anim_target.global_position + 0.25*upper_right_leg.anim_target.global_position + 0.25*lower_left_leg.anim_target.global_position + 0.25*lower_right_leg.anim_target.global_position
	distance_delta = target_position - global_position
	
	upper_left_leg.leg_target.global_position = wall.left_scaffolds[upper_left_leg.target_scaffold].grapple_point.global_position
	upper_right_leg.leg_target.global_position = wall.right_scaffolds[upper_right_leg.target_scaffold].grapple_point.global_position
	lower_left_leg.leg_target.global_position = wall.left_scaffolds[lower_left_leg.target_scaffold].grapple_point.global_position
	lower_right_leg.leg_target.global_position = wall.right_scaffolds[lower_right_leg.target_scaffold].grapple_point.global_position
	
	if Input.is_action_just_pressed("ui_up"):
		move_upper_right_leg()
	if Input.is_action_just_pressed("ui_left"):
		move_upper_left_leg()
	if Input.is_action_just_pressed("ui_down"):
		move_lower_left_leg()
	if Input.is_action_just_pressed("ui_right"):
		move_lower_right_leg()

func move_upper_left_leg():
	var next_scaffold
	var closest_distance := -999999.9
	
	for scaffold in wall.left_scaffolds:
		if scaffold.position.y > upper_left_leg.global_position.y:
			continue
		elif scaffold.position.y > closest_distance:
			closest_distance = scaffold.position.y
			next_scaffold = scaffold
	
	if next_scaffold and next_scaffold.vacant:
		wall.left_scaffolds[upper_left_leg.target_scaffold].vacant = true
		upper_left_leg.target_scaffold = wall.left_scaffolds.find(next_scaffold)
		wall.left_scaffolds[upper_left_leg.target_scaffold].vacant = false
		upper_left_leg.leg_target.position = next_scaffold.grapple_point.position

func move_upper_right_leg():
	var next_scaffold
	var closest_distance := -999999.9
	
	for scaffold in wall.right_scaffolds:
		if scaffold.position.y > upper_right_leg.global_position.y:
			continue
		elif scaffold.position.y > closest_distance:
			closest_distance = scaffold.position.y
			next_scaffold = scaffold
	
	if next_scaffold and next_scaffold.vacant:
		wall.right_scaffolds[upper_right_leg.target_scaffold].vacant = true
		upper_right_leg.target_scaffold = wall.right_scaffolds.find(next_scaffold)
		wall.right_scaffolds[upper_right_leg.target_scaffold].vacant = false
		upper_right_leg.leg_target.position = next_scaffold.grapple_point.position

func move_lower_left_leg():
	var next_scaffold
	var closest_distance := -999999.9
	
	for scaffold in wall.left_scaffolds:
		if scaffold.position.y > lower_left_leg.global_position.y:
			continue
		elif scaffold.position.y > closest_distance:
			closest_distance = scaffold.position.y
			next_scaffold = scaffold
	
	if next_scaffold and next_scaffold.vacant:
		wall.left_scaffolds[lower_left_leg.target_scaffold].vacant = true
		lower_left_leg.target_scaffold = wall.left_scaffolds.find(next_scaffold)
		wall.left_scaffolds[upper_left_leg.target_scaffold].vacant = false
		lower_left_leg.leg_target.position = next_scaffold.grapple_point.position

func move_lower_right_leg():
	var next_scaffold
	var closest_distance := -999999.9
	
	for scaffold in wall.right_scaffolds:
		if scaffold.position.y > lower_right_leg.global_position.y:
			continue
		elif scaffold.position.y > closest_distance:
			closest_distance = scaffold.position.y
			next_scaffold = scaffold
	
	if next_scaffold and next_scaffold.vacant:
		wall.right_scaffolds[lower_right_leg.target_scaffold].vacant = true
		lower_right_leg.target_scaffold = wall.right_scaffolds.find(next_scaffold)
		wall.right_scaffolds[lower_right_leg.target_scaffold].vacant = false
		lower_right_leg.leg_target.position = next_scaffold.grapple_point.position

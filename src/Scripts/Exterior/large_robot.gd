extends Node2D

@export var wall: Node2D
@export var lava: Node2D

@onready var hitbox := $Hitbox
@onready var upper_left_leg := $LargeRobotLegUL
@onready var upper_right_leg := $LargeRobotLegUR
@onready var lower_left_leg := $LargeRobotLegDL
@onready var lower_right_leg := $LargeRobotLegDR
@onready var autoturret := $AutoTurret

var target_position := Vector2.ZERO
var distance_climbed := 0.0
var distance_delta := Vector2.ZERO

var enemies: Array[RigidBody2D] = []

var dead := false

#var health := 20.0
#var shield := 100.0
#var fuel := 100.0
#var ammo := 100.0

signal kill_enemy(index: int)
signal died

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	upper_left_leg.target_scaffold = 1
	upper_right_leg.target_scaffold = 1
	lower_left_leg.target_scaffold = 0
	lower_right_leg.target_scaffold = 0
	
	wall.left_scaffolds[0].vacant = false
	wall.left_scaffolds[1].vacant = false
	wall.right_scaffolds[0].vacant = false
	wall.right_scaffolds[1].vacant = false
	
	autoturret.enemies = enemies

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_distance(delta)
	
	upper_left_leg.leg_target.global_position = wall.left_scaffolds[upper_left_leg.target_scaffold].grapple_point.global_position
	upper_right_leg.leg_target.global_position = wall.right_scaffolds[upper_right_leg.target_scaffold].grapple_point.global_position
	lower_left_leg.leg_target.global_position = wall.left_scaffolds[lower_left_leg.target_scaffold].grapple_point.global_position
	lower_right_leg.leg_target.global_position = wall.right_scaffolds[lower_right_leg.target_scaffold].grapple_point.global_position
	
	#if Input.is_action_just_pressed("ui_up"):
		#move_upper_right_leg()
	#if Input.is_action_just_pressed("ui_left"):
		#move_upper_left_leg()
	#if Input.is_action_just_pressed("ui_down"):
		#move_lower_left_leg()
	#if Input.is_action_just_pressed("ui_right"):
		#move_lower_right_leg()
	
	if lava.hitbox.overlaps_body(hitbox):
		deal_damage(lava.shield_damage * delta)
	
	if Global.health < 0.0:
		die()
	
	if lava.started:
		Global.fuel -= 1.0 * delta
		if Global.fuel < 0.0:
			Global.fuel = -0.01
	
	if autoturret.is_firing:
		Global.ammo -= 2.5 * delta
		if Global.ammo < 0.0:
			Global.ammo = -0.01

func die():
	dead = true
	died.emit()

func deal_damage(amount: float):
	if Global.shield > 0.0:
		Global.shield -= amount
		if Global.shield <= 0.0:
			Global.shield = -0.01
	elif Global.health > 0.0:
		Global.health -= amount
		if Global.health <= 0.0:
			Global.health = -0.01

func update_distance(delta: float):
	target_position = 0.25 * (upper_left_leg.anim_target.global_position + upper_right_leg.anim_target.global_position + lower_left_leg.anim_target.global_position + lower_right_leg.anim_target.global_position)
	distance_delta = -(target_position - global_position) * delta
	distance_climbed += distance_delta.y
	wall.distance_climbed = distance_climbed
	wall.distance_delta = distance_delta.y
	lava.distance_delta = distance_delta.y

func add_enemies(new_enemies: Array[RigidBody2D]):
	#enemies = new_enemies
	autoturret.enemies = new_enemies

func remove_enemy(index):
	autoturret.enemies.remove_at(index)

func move_upper_left_leg():
	var next_scaffold
	var closest_distance := -999999.9
	
	for scaffold in wall.left_scaffolds:
		if lower_left_leg.leg_target.position.y > get_viewport().get_visible_rect().size.y or lower_right_leg.leg_target.position.y > get_viewport().get_visible_rect().size.y:
			continue
		elif scaffold.anchor.global_position.y > upper_left_leg.global_position.y or scaffold.anchor.global_position.y > upper_left_leg.leg_target.global_position.y - 16.0:
			continue
		elif scaffold.anchor.global_position.y > closest_distance:
			closest_distance = scaffold.anchor.global_position.y
			next_scaffold = scaffold
	
	if next_scaffold and next_scaffold.vacant and Global.fuel > 0.0 and not dead:
		wall.left_scaffolds[upper_left_leg.target_scaffold].vacant = true
		upper_left_leg.target_scaffold = wall.left_scaffolds.find(next_scaffold)
		wall.left_scaffolds[upper_left_leg.target_scaffold].vacant = false
		upper_left_leg.leg_target.position = next_scaffold.grapple_point.position

func move_upper_right_leg():
	var next_scaffold
	var closest_distance := -999999.9
	
	for scaffold in wall.right_scaffolds:
		if lower_left_leg.leg_target.position.y > get_viewport().get_visible_rect().size.y or lower_right_leg.leg_target.position.y > get_viewport().get_visible_rect().size.y:
			continue
		elif scaffold.anchor.global_position.y > upper_right_leg.global_position.y or scaffold.anchor.global_position.y > upper_right_leg.leg_target.global_position.y - 16.0:
			continue
		elif scaffold.anchor.global_position.y > closest_distance:
			closest_distance = scaffold.anchor.global_position.y
			next_scaffold = scaffold
	
	if next_scaffold and next_scaffold.vacant and Global.fuel > 0.0 and not dead:
		wall.right_scaffolds[upper_right_leg.target_scaffold].vacant = true
		upper_right_leg.target_scaffold = wall.right_scaffolds.find(next_scaffold)
		wall.right_scaffolds[upper_right_leg.target_scaffold].vacant = false
		upper_right_leg.leg_target.position = next_scaffold.grapple_point.position

func move_lower_left_leg():
	var next_scaffold
	var closest_distance := -999999.9
	
	for scaffold in wall.left_scaffolds:
		if scaffold.anchor.global_position.y > lower_left_leg.global_position.y or scaffold.anchor.global_position.y > lower_left_leg.leg_target.global_position.y - 16.0:
			continue
		elif scaffold.anchor.global_position.y > closest_distance:
			closest_distance = scaffold.anchor.global_position.y
			next_scaffold = scaffold
	
	if next_scaffold and next_scaffold.vacant and Global.fuel > 0.0 and not dead:
		wall.left_scaffolds[lower_left_leg.target_scaffold].vacant = true
		lower_left_leg.target_scaffold = wall.left_scaffolds.find(next_scaffold)
		wall.left_scaffolds[upper_left_leg.target_scaffold].vacant = false
		lower_left_leg.leg_target.position = next_scaffold.grapple_point.position

func move_lower_right_leg():
	var next_scaffold
	var closest_distance := -999999.9
	
	for scaffold in wall.right_scaffolds:
		if scaffold.anchor.global_position.y > lower_right_leg.global_position.y or scaffold.anchor.global_position.y > lower_right_leg.leg_target.global_position.y - 16.0:
			continue
		elif scaffold.anchor.global_position.y > closest_distance:
			closest_distance = scaffold.anchor.global_position.y
			next_scaffold = scaffold
	
	if next_scaffold and next_scaffold.vacant and Global.fuel > 0.0 and not dead:
		wall.right_scaffolds[lower_right_leg.target_scaffold].vacant = true
		lower_right_leg.target_scaffold = wall.right_scaffolds.find(next_scaffold)
		wall.right_scaffolds[lower_right_leg.target_scaffold].vacant = false
		lower_right_leg.leg_target.position = next_scaffold.grapple_point.position


func _on_auto_turret_kill_enemy(index: int) -> void:
	kill_enemy.emit(index)

extends Node

var player: CharacterBody2D
var camera: Camera2D


const MAX_HEALTH := 100.0
const MAX_SHIELD := 100.0
const MAX_FUEL   := 100.0
const MAX_AMMO   := 100.0

var health := 100.0
var shield := 100.0
var fuel := 100.0
var ammo := 100.0

var distance_bar_value := 0.0
var you_marker_position := 0.0
var danger_marker_position := 0.0

func increase_stat(stat: float, value: float):
	stat += value
	print(stat)
func decrease_stat(stat: float, value: float):
	stat -= value
	print(stat)

func change_room(room_position: Vector2, room_size: Vector2):
	camera.current_room_center = room_position
	camera.current_room_size = room_size

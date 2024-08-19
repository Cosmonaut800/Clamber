extends Node

var player: CharacterBody2D
var camera: Camera2D

var health := 20.0
var shield := 100.0
var fuel := 100.0
var ammo := 100.0

func change_room(room_position: Vector2, room_size: Vector2):
	camera.current_room_center = room_position
	camera.current_room_size = room_size

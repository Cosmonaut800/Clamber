extends Node2D

@onready var sprite := $AnimatedSprite2D
@onready var top_arm_sfx := $"../../AudioStreamPlayerUpperArm"
@onready var bot_arm_sfx := $"../../AudioStreamPlayerBottomArm"

signal activated

func _ready() -> void:
	sprite.set_frame(0)

func _on_area_2d_body_entered(body: Node2D) -> void:
	activated.emit()
	sprite.set_frame(1)

func _on_area_2d_body_exited(body: Node2D) -> void:
	sprite.set_frame(0)

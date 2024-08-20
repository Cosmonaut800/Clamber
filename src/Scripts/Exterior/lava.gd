extends Node2D

@onready var hitbox := $Hitbox

var shield_damage := 20.0 #damage to shield per second
var health_damage := 100.0 #damage to health per second

var offscreen_timer := 0.0
var distance_delta := 0.0

var started := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if started:
		position.y += -20.0 * delta + distance_delta

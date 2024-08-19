extends Node


var current_scene = null
func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count()-1)
	print_debug(current_scene)

func switch_scene(res_path):
	call_deferred("_deferred_switch_scene", res_path)

func _deferred_switch_scene(res_path):
	var room = current_scene.get_node("Room")
	print(room.get_child(0).to_string())
	room.get_child(0).queue_free()
	var scene = load(res_path)
	current_scene = scene.instantiate()
	room.add_child(current_scene)
	

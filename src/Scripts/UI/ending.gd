extends Control

@onready var anim_tree := $AnimationTree
@onready var restart_button := $RestartButton

var be_quiet := false

func _process(delta):
	if be_quiet:
		AudioServer.set_bus_volume_db(0, linear_to_db(db_to_linear(AudioServer.get_bus_volume_db(0)) - 0.3 * delta))

func play_winning_animation():
	anim_tree.set("parameters/conditions/you_won", true)

func play_losing_animation():
	anim_tree.set("parameters/conditions/you_died", true)

func fade_audio_out():
	restart_button.set_visible(true)
	be_quiet = true


func _on_restart_button_pressed() -> void:
	Global.restart_game()

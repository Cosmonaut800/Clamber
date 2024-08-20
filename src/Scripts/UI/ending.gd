extends Control

@onready var anim_tree := $AnimationTree

func play_winning_animation():
	anim_tree.set("parameters/conditions/you_won", true)

func play_losing_animation():
	anim_tree.set("parameters/conditions/you_died", true)

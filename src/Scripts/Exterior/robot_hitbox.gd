extends StaticBody2D

@onready var large_robot := $".."

func deal_damage(amount: float):
	large_robot.deal_damage(amount)

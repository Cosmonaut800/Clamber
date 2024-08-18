extends Node2D

@onready var anchor := $Anchor
@onready var grapple_point := $Anchor/GrapplePoint
@onready var graphics: Array = [$Anchor/Graphics1,
								$Anchor/Graphics2]

var vacant := true

func set_graphics(index: int):
	for graphic in graphics:
		graphic.set_visible(false)
	
	if index < 0 or index >= graphics.size():
		graphics[0].set_visible(true)
		print("Scaffold graphics index out of range: " + str(index))
	else:
		graphics[index].set_visible(true)

func randomize_anchor(range: float):
	anchor.position.y = randf_range(-range, range)

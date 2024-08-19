extends CanvasLayer

@onready var healthbar := $UI/HealthBar
@onready var shieldbar := $UI/ShieldBar
@onready var fuelbar := $UI/FuelBar
@onready var ammobar := $UI/AmmoBar

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	healthbar.set_value_no_signal(Global.health)
	shieldbar.set_value_no_signal(Global.shield)
	fuelbar.set_value_no_signal(Global.fuel)
	ammobar.set_value_no_signal(Global.ammo)

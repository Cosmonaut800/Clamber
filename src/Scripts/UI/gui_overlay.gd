extends CanvasLayer

@onready var player = get_parent().get_node("Player")

@onready var healthbar := $UI/HealthBar
@onready var shieldbar := $UI/ShieldBar
@onready var fuelbar := $UI/FuelBar
@onready var ammobar := $UI/AmmoBar
@onready var has_ammo_sign = $HasAmmo
@onready var has_rad_rod_sign = $HasRadRod
@onready var distancebar := $DistanceBar
@onready var you_marker := $DistanceMeter/YouMarker
@onready var danger_marker := $DistanceMeter/DangerMarker

# Called when the node enters the scene tree for the first time.
func _ready():
	has_ammo_sign.hide()
	has_rad_rod_sign.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if player.has_ammo:
		has_ammo_sign.show()
	else:
		has_ammo_sign.hide()
	
	if player.has_old_rad_rod || player.has_new_rad_rod:
		has_rad_rod_sign.show()
	else:
		has_rad_rod_sign.hide()
	
	healthbar.set_value_no_signal(Global.health)
	shieldbar.set_value_no_signal(Global.shield)
	fuelbar.set_value_no_signal(Global.fuel)
	ammobar.set_value_no_signal(Global.ammo)
	
	distancebar.value = Global.distance_bar_value
	you_marker.position.y = Global.you_marker_position
	danger_marker.position.y = Global.danger_marker_position

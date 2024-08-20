extends Node2D

enum BUTTON {UL, UR, DL, DR}

@onready var player := $Player
@onready var door := $Door
@onready var door_marker := $DoorMarker

signal button_activated(index: int)
signal door_entered

func _on_button_ul_activated() -> void:
	button_activated.emit(BUTTON.UL)

func _on_button_ur_activated() -> void:
	button_activated.emit(BUTTON.UR)

func _on_button_dl_activated() -> void:
	button_activated.emit(BUTTON.DL)

func _on_button_dr_activated() -> void:
	button_activated.emit(BUTTON.DR)

func _on_door_door_entered() -> void:
	door_entered.emit()

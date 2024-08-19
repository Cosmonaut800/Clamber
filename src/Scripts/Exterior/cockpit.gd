extends Node2D

enum BUTTON {UL, UR, DL, DR}

signal button_activated(index: int)

func _on_button_ul_activated() -> void:
	button_activated.emit(BUTTON.UL)

func _on_button_ur_activated() -> void:
	button_activated.emit(BUTTON.UR)

func _on_button_dl_activated() -> void:
	button_activated.emit(BUTTON.DL)

func _on_button_dr_activated() -> void:
	button_activated.emit(BUTTON.DR)

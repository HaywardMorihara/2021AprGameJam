extends "res://cutscene/Cutscene.gd"


func _input(event):
	if Input.is_action_pressed("next"):
		GlobalTimer.start()

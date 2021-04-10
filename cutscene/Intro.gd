extends Control


func _input(event):
	if event is InputEventKey and event.pressed or Input.is_action_pressed("next"):
		GlobalTimer.start()
		get_tree().change_scene("res://house/InteriorHouse.tscn")

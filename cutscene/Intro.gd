extends Control


func _input(event):
	if event is InputEventKey and event.pressed or Input.is_action_pressed("next"):
		get_tree().change_scene("res://house/PlayerHouse.tscn")

extends Control

export var next_scene : String

func _input(event):
	if Input.is_action_pressed("next"):
		get_tree().change_scene(next_scene)

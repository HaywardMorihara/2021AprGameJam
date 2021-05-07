extends Node2D




func _on_Area2D_body_entered(body):
	Global.previous_scene = get_tree().current_scene.filename
	get_tree().change_scene("res://map/Map.tscn")

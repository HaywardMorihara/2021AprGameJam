extends Area2D


func _on_Location_body_entered(body):
	#	https://godotengine.org/qa/65414/how-to-tell-what-sort-of-body-ive-hit-in-area-body_entered
	print(body.name)
	if body.name == "Player":
		get_tree().change_scene("res://map/Map.tscn")
		

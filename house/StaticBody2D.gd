extends Area2D

export (String) var destination_scene

# TODO Require an export var?

func _on_Location_body_entered(body):
	#	https://godotengine.org/qa/65414/how-to-tell-what-sort-of-body-ive-hit-in-area-body_entered
	if body.name == "PlayerBody":
		get_tree().change_scene(destination_scene)
		

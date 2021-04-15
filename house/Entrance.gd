extends Area2D

export (String) var destination_scene
export (bool) var is_witch_entrance

# TODO Require an export var?

func _on_Location_body_entered(body):
	#	https://godotengine.org/qa/65414/how-to-tell-what-sort-of-body-ive-hit-in-area-body_entered
	if body.name == "Player":
		Global.next_exit_map_position = $ExitPosition.global_position
		if is_witch_entrance and not Global.has_player_entered_witch_house:
			Global.has_player_entered_witch_house = true
			get_tree().change_scene("res://cutscene/WitchCutscene.tscn")
		else:
			get_tree().change_scene(destination_scene)
		
